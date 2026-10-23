-- ========================================================
-- Master DDL Schema Script for Dataset_01_Fintech_Banking_Wealth_Risk_20x30_source
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 20
-- Domains Included: Dataset_03_Finance_Banking_Dataset, Dataset_06_Asset_Management_Wealth_Dataset, Dataset_08_Banking_Fraud_Risk_Compliance_Dataset
-- ========================================================

CREATE TABLE tbl_accounts (
    account_id                     INT             PRIMARY KEY                                                , -- Account primary key ID
    account_number                 VARCHAR(20)     NOT NULL                                                   , -- Unique bank account number
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- Parent customer ID
    account_type                   VARCHAR(20)     NOT NULL                                                   , -- CHECKING/SAVINGS/MONEY_MARKET
    currency_code                  VARCHAR(3)      NOT NULL                                                   , -- ISO currency code USD/EUR
    current_balance                DECIMAL(12,2)   NOT NULL                                                   , -- Current account balance
    available_balance              DECIMAL(12,2)   NOT NULL                                                   , -- Available account balance
    status_code                    VARCHAR(10)     NOT NULL                                                   , -- ACTIVE/CLOSED/FROZEN
    created_at                     TIMESTAMP       NOT NULL                                                     -- Account creation timestamp
);

CREATE TABLE tbl_audit_logs (
    log_id                         INT             PRIMARY KEY                                                , -- Audit log primary key ID
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- Operator user or system ID
    action_type                    VARCHAR(30)     NOT NULL                                                   , -- LOGIN/TRANSFER/UPDATE_LIMIT
    entity_name                    VARCHAR(40)     NOT NULL                                                   , -- Target entity table
    entity_id                      INT             NOT NULL                                                   , -- Target entity record ID
    ip_address                     VARCHAR(45)     NOT NULL                                                   , -- Client IP address
    log_timestamp                  TIMESTAMP       NOT NULL                                                   , -- Audit log timestamp
    status_code                    VARCHAR(15)     NOT NULL                                                     -- SUCCESS/DENIED
);

CREATE TABLE tbl_branches (
    branch_id                      INT             PRIMARY KEY                                                , -- Branch primary key ID
    branch_code                    VARCHAR(10)     NOT NULL                                                   , -- Unique branch location code
    branch_name                    VARCHAR(60)     NOT NULL                                                   , -- Branch designation name
    address_line                   VARCHAR(100)    NOT NULL                                                   , -- Street address line
    city                           VARCHAR(50)     NOT NULL                                                   , -- City location
    state_code                     VARCHAR(5)      NOT NULL                                                   , -- State postal code
    postal_code                    VARCHAR(10)     NOT NULL                                                   , -- ZIP/Postal code
    manager_name                   VARCHAR(60)     NOT NULL                                                   , -- Branch manager name
    status_code                    VARCHAR(10)     NOT NULL                                                     -- OPEN/CLOSED/REMODEL
);

CREATE TABLE tbl_credit_cards (
    card_id                        INT             PRIMARY KEY                                                , -- Credit card primary key ID
    account_id                     INT             NOT NULL REFERENCES tbl_accounts(account_id)               , -- Associated checking/card account ID
    card_number_masked             VARCHAR(19)     NOT NULL                                                   , -- Masked credit card number
    card_type                      VARCHAR(20)     NOT NULL                                                   , -- VISA/MASTERCARD/AMEX
    credit_limit                   DECIMAL(10,2)   NOT NULL                                                   , -- Approved credit limit
    current_balance                DECIMAL(10,2)   NOT NULL                                                   , -- Current statement balance
    expiry_date                    VARCHAR(7)      NOT NULL                                                   , -- Expiration date MM/YYYY
    is_active                      VARCHAR(1)      NOT NULL                                                   , -- Active flag Y/N
    status_code                    VARCHAR(15)     NOT NULL                                                     -- ISSUED/BLOCKED/EXPIRED
);

CREATE TABLE tbl_customers (
    customer_id                    INT             PRIMARY KEY                                                , -- Customer primary key ID
    tax_identifier                 VARCHAR(11)     NOT NULL                                                   , -- SSN or Tax ID number
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- Customer given name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Customer family name
    email_address                  VARCHAR(100)    NOT NULL                                                   , -- Primary email contact
    phone_number                   VARCHAR(20)     NOT NULL                                                   , -- Primary phone contact
    kyc_status                     VARCHAR(15)     NOT NULL                                                   , -- VERIFIED/PENDING/REJECTED
    risk_rating                    VARCHAR(10)     NOT NULL                                                   , -- LOW/MEDIUM/HIGH
    created_at                     TIMESTAMP       NOT NULL                                                     -- Customer onboarding timestamp
);

CREATE TABLE tbl_investment_portfolios (
    portfolio_id                   INT             PRIMARY KEY                                                , -- Portfolio primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- Investor customer ID
    portfolio_name                 VARCHAR(60)     NOT NULL                                                   , -- Portfolio title
    portfolio_type                 VARCHAR(25)     NOT NULL                                                   , -- GROWTH/BALANCED/CONSERVATIVE
    total_value                    DECIMAL(12,2)   NOT NULL                                                   , -- Total asset market value
    risk_level                     VARCHAR(15)     NOT NULL                                                   , -- MODERATE/AGGRESSIVE/LOW
    created_at                     TIMESTAMP       NOT NULL                                                   , -- Portfolio creation date
    status_code                    VARCHAR(10)     NOT NULL                                                     -- ACTIVE/LIQUIDATED
);

CREATE TABLE tbl_loan_payments (
    payment_id                     INT             PRIMARY KEY                                                , -- Loan payment primary key ID
    loan_id                        INT             NOT NULL REFERENCES tbl_loans(loan_id)                     , -- Associated loan ID
    payment_date                   DATE            NOT NULL                                                   , -- Payment execution date
    principal_paid                 DECIMAL(10,2)   NOT NULL                                                   , -- Principal portion paid
    interest_paid                  DECIMAL(10,2)   NOT NULL                                                   , -- Interest portion paid
    total_paid                     DECIMAL(10,2)   NOT NULL                                                   , -- Total amount paid
    payment_method                 VARCHAR(20)     NOT NULL                                                   , -- AUTOPAY/WIRE/CHECK
    status_code                    VARCHAR(15)     NOT NULL                                                     -- POSTED/PENDING/REVERSED
);

CREATE TABLE tbl_loans (
    loan_id                        INT             PRIMARY KEY                                                , -- Loan primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- Borrower customer ID
    loan_type                      VARCHAR(20)     NOT NULL                                                   , -- MORTGAGE/AUTO/PERSONAL/BUSINESS
    principal_amount               DECIMAL(12,2)   NOT NULL                                                   , -- Original loan principal
    interest_rate                  DECIMAL(5,2)    NOT NULL                                                   , -- Annual percentage interest rate
    term_months                    INT             NOT NULL                                                   , -- Loan duration in months
    start_date                     DATE            NOT NULL                                                   , -- Loan disbursement date
    status_code                    VARCHAR(15)     NOT NULL                                                   , -- ACTIVE/PAID_OFF/DEFAULTED
    remaining_balance              DECIMAL(12,2)   NOT NULL                                                     -- Outstanding principal balance
);

CREATE TABLE tbl_transactions (
    transaction_id                 INT             PRIMARY KEY                                                , -- Transaction primary key ID
    account_id                     INT             NOT NULL REFERENCES tbl_accounts(account_id)               , -- Associated account ID
    txn_reference                  VARCHAR(36)     NOT NULL                                                   , -- Unique transaction reference code
    txn_type                       VARCHAR(20)     NOT NULL                                                   , -- DEPOSIT/WITHDRAWAL/TRANSFER/FEE
    amount                         DECIMAL(10,2)   NOT NULL                                                   , -- Transaction amount
    txn_date                       TIMESTAMP       NOT NULL                                                   , -- Transaction timestamp
    description                    VARCHAR(100)    NOT NULL                                                   , -- Transaction narrative note
    status_code                    VARCHAR(15)     NOT NULL                                                     -- COMPLETED/PENDING/FAILED
);

CREATE TABLE tbl_wire_transfers (
    transfer_id                    INT             PRIMARY KEY                                                , -- Wire transfer primary key ID
    source_account_id              INT             NOT NULL REFERENCES tbl_accounts(account_id)               , -- Originating account ID
    dest_account_number            VARCHAR(34)     NOT NULL                                                   , -- Destination IBAN or account
    swift_code                     VARCHAR(11)     NOT NULL                                                   , -- Destination SWIFT/BIC code
    amount                         DECIMAL(12,2)   NOT NULL                                                   , -- Transfer amount
    fee_amount                     DECIMAL(8,2)    NOT NULL                                                   , -- Service fee charged
    transfer_date                  TIMESTAMP       NOT NULL                                                   , -- Execution timestamp
    status_code                    VARCHAR(15)     NOT NULL                                                     -- SETTLED/PROCESSING/CANCELLED
);

CREATE TABLE tbl_asset_transactions (
    transaction_id                 INT             PRIMARY KEY                                                , -- Transaction primary key ID
    account_id                     INT             NOT NULL REFERENCES tbl_investment_accounts(account_id)    , -- FK to tbl_investment_accounts
    security_id                    INT             NOT NULL REFERENCES tbl_security_assets(security_id)       , -- FK to tbl_security_assets
    txn_type                       VARCHAR(10)     NOT NULL                                                   , -- BUY/SELL/DIVIDEND
    total_amount                   DECIMAL(12,2)   NOT NULL                                                     -- Total dollar amount
);

CREATE TABLE tbl_clients (
    client_id                      INT             PRIMARY KEY                                                , -- Client primary key ID
    tax_identifier                 VARCHAR(11)     NOT NULL                                                   , -- SSN or Tax ID
    client_name                    VARCHAR(100)    NOT NULL                                                     -- Wealth client name
);

CREATE TABLE tbl_investment_accounts (
    account_id                     INT             PRIMARY KEY                                                , -- Account primary key ID
    client_id                      INT             NOT NULL REFERENCES tbl_clients(client_id)                 , -- FK to tbl_clients
    account_type                   VARCHAR(30)     NOT NULL                                                     -- INDIVIDUAL_BROKERAGE/IRA/TRUST
);

CREATE TABLE tbl_portfolio_holdings (
    holding_id                     INT             PRIMARY KEY                                                , -- Holding primary key ID
    account_id                     INT             NOT NULL REFERENCES tbl_investment_accounts(account_id)    , -- FK to tbl_investment_accounts
    security_id                    INT             NOT NULL REFERENCES tbl_security_assets(security_id)       , -- FK to tbl_security_assets
    shares_count                   DECIMAL(12,4)   NOT NULL                                                     -- Quantity of shares
);

CREATE TABLE tbl_security_assets (
    security_id                    INT             PRIMARY KEY                                                , -- Security primary key ID
    ticker_symbol                  VARCHAR(10)     NOT NULL                                                   , -- AAPL/MSFT/GOOGL
    security_name                  VARCHAR(100)    NOT NULL                                                     -- Asset name
);

CREATE TABLE tbl_aml_suspicious_reports (
    sar_report_id                  INT             PRIMARY KEY                                              , -- SAR report primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customer_risk_profiles(customer_id), -- FK to tbl_customer_risk_profiles
    filing_date                    DATE            NOT NULL                                                 , -- Official regulatory filing date
    reporting_officer_id           INT             NOT NULL                                                 , -- AML compliance officer ID
    suspicious_activity_code       VARCHAR(25)     NOT NULL                                                 , -- FinCEN suspicious activity code
    total_suspicious_amount_usd    DECIMAL(12,2)   NOT NULL                                                 , -- Total aggregate suspicious USD
    fincen_control_number          VARCHAR(25)     NOT NULL                                                 , -- FinCEN regulatory tracking number
    narrative_summary              VARCHAR(250)    NOT NULL                                                 , -- Summary narrative of suspicious activity
    investigation_start_date       DATE            NOT NULL                                                 , -- Investigation start date
    investigation_end_date         DATE            NOT NULL                                                 , -- Investigation closure date
    law_enforcement_contacted_flag BOOLEAN         NOT NULL                                                 , -- FBI/Law enforcement notified flag
    account_frozen_flag            BOOLEAN         NOT NULL                                                 , -- Account restriction/freeze flag
    regulatory_body_code           VARCHAR(15)     NOT NULL                                                 , -- FINCEN, FCA, MAS, FINMA
    jurisdiction_code              VARCHAR(10)     NOT NULL                                                 , -- Jurisdiction legal code
    case_file_path                 VARCHAR(100)    NOT NULL                                                 , -- Encrypted evidence dossier file path
    approval_status                VARCHAR(20)     NOT NULL                                                 , -- APPROVED, PENDING_SIGNATURE, FILED
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- FILED, DRAFT, CLOSED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Compliance officer sign-off notes
);

CREATE TABLE tbl_customer_risk_profiles (
    customer_id                    INT             PRIMARY KEY                                              , -- Customer primary key ID
    customer_number                VARCHAR(20)     NOT NULL                                                 , -- Unique customer master ID
    full_name                      VARCHAR(100)    NOT NULL                                                 , -- Customer full legal name
    date_of_birth                  DATE            NOT NULL                                                 , -- Customer birth date
    national_id_ssn                VARCHAR(20)     NOT NULL                                                 , -- Encrypted SSN or national tax ID
    is_pep_flag                    BOOLEAN         NOT NULL                                                 , -- Politically Exposed Person flag
    sanctions_check_status         VARCHAR(25)     NOT NULL                                                 , -- CLEARED, MATCH_FOUND, PENDING
    kyc_verification_status        VARCHAR(25)     NOT NULL                                                 , -- VERIFIED, EXPIRED, INCOMPLETE
    kyc_last_updated_date          DATE            NOT NULL                                                 , -- Date of last KYC refresh
    risk_rating_category           VARCHAR(15)     NOT NULL                                                 , -- LOW, MEDIUM, HIGH, CRITICAL
    credit_score                   INT             NOT NULL                                                 , -- FICO credit score 300-850
    annual_income_usd              DECIMAL(12,2)   NOT NULL                                                 , -- Verified annual income USD
    employment_status              VARCHAR(30)     NOT NULL                                                 , -- EMPLOYED, SELF_EMPLOYED, RETIRED
    occupation_title               VARCHAR(50)     NOT NULL                                                 , -- Job title or business domain
    residence_country              VARCHAR(3)      NOT NULL                                                 , -- Country of residence ISO-3
    tax_residence_country          VARCHAR(3)      NOT NULL                                                 , -- FATCA tax jurisdiction code
    account_count                  INT             NOT NULL                                                 , -- Total active bank accounts owned
    total_balance_usd              DECIMAL(14,2)   NOT NULL                                                 , -- Aggregate balance across accounts
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- ACTIVE, FROZEN, CLOSED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Compliance audit comments
);

CREATE TABLE tbl_financial_transactions (
    transaction_id                 INT             PRIMARY KEY                                              , -- Transaction primary key ID
    transaction_reference          VARCHAR(30)     NOT NULL                                                 , -- SWIFT/ISO20022 transaction reference
    sender_account_id              INT             NOT NULL                                                 , -- Sender account ID
    receiver_account_id            INT             NOT NULL                                                 , -- Receiver account ID
    transaction_amount_usd         DECIMAL(12,2)   NOT NULL                                                 , -- Transaction principal amount USD
    transaction_timestamp          TIMESTAMP       NOT NULL                                                 , -- Transaction execution time
    transaction_type               VARCHAR(30)     NOT NULL                                                 , -- WIRE_TRANSFER, ACH, CARD_PAYMENT, ATM
    channel_type                   VARCHAR(20)     NOT NULL                                                 , -- ONLINE_BANKING, MOBILE_APP, BRANCH, POS
    merchant_category_code         VARCHAR(10)     NOT NULL                                                 , -- MCC code identifier
    location_city                  VARCHAR(50)     NOT NULL                                                 , -- Transaction city location
    location_country               VARCHAR(3)      NOT NULL                                                 , -- ISO-3 country code
    ip_address                     VARCHAR(45)     NOT NULL                                                 , -- Client IP address
    device_fingerprint             VARCHAR(40)     NOT NULL                                                 , -- Browser / device unique hash
    is_cross_border                BOOLEAN         NOT NULL                                                 , -- International transfer flag
    currency_code                  VARCHAR(3)      NOT NULL                                                 , -- Transaction ISO currency code
    exchange_rate                  DECIMAL(8,4)    NOT NULL                                                 , -- Applied currency exchange rate
    fee_amount_usd                 DECIMAL(8,2)    NOT NULL                                                 , -- Transaction service fee USD
    risk_score_numeric             INT             NOT NULL                                                 , -- Real-time AI fraud risk score 1-100
    fraud_flag                     BOOLEAN         NOT NULL                                                 , -- Confirmed fraud indicator flag
    aml_flagged_status             VARCHAR(25)     NOT NULL                                                 , -- PASSED, SUSPICIOUS, BLOCKED
    authorization_code             VARCHAR(15)     NOT NULL                                                 , -- Payment gateway authorization ID
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    notes                          VARCHAR(150)    NOT NULL                                                   -- Risk engine processing notes
);

CREATE TABLE tbl_fraud_detection_alerts (
    alert_id                       INT             PRIMARY KEY                                              , -- Alert primary key ID
    transaction_id                 INT             NOT NULL REFERENCES tbl_financial_transactions(transaction_id), -- FK to tbl_financial_transactions
    customer_id                    INT             NOT NULL REFERENCES tbl_customer_risk_profiles(customer_id), -- FK to tbl_customer_risk_profiles
    alert_timestamp                TIMESTAMP       NOT NULL                                                 , -- Fraud rule trigger timestamp
    rule_triggered_id              VARCHAR(20)     NOT NULL                                                 , -- Rule catalog code
    rule_name                      VARCHAR(80)     NOT NULL                                                 , -- Rule description title
    severity_level                 VARCHAR(15)     NOT NULL                                                 , -- CRITICAL, HIGH, MEDIUM, LOW
    alert_score                    INT             NOT NULL                                                 , -- Anomaly risk score 1-100
    investigator_user_id           INT             NOT NULL                                                 , -- Assigned AML investigator ID
    investigation_status           VARCHAR(25)     NOT NULL                                                 , -- OPEN, UNDER_REVIEW, CLOSED, ESCALATED
    resolution_outcome             VARCHAR(40)     NOT NULL                                                 , -- FALSE_POSITIVE, CONFIRMED_FRAUD, SAR_FILED
    resolution_timestamp           TIMESTAMP       NOT NULL                                                 , -- Alert resolution timestamp
    is_false_positive              BOOLEAN         NOT NULL                                                 , -- False positive determination flag
    reported_to_authorities_flag   BOOLEAN         NOT NULL                                                 , -- FinCEN / FIU report flag
    loss_amount_usd                DECIMAL(10,2)   NOT NULL                                                 , -- Confirmed financial loss USD
    recovered_amount_usd           DECIMAL(10,2)   NOT NULL                                                 , -- Recovered funds USD
    comments                       VARCHAR(200)    NOT NULL                                                 , -- Investigator notes and rationale
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                   -- NEW, ASSIGNED, COMPLETED
);

CREATE TABLE tbl_sanction_watchlist_matches (
    match_id                       INT             PRIMARY KEY                                              , -- Match record primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customer_risk_profiles(customer_id), -- FK to tbl_customer_risk_profiles
    watchlist_name                 VARCHAR(50)     NOT NULL                                                 , -- OFAC, UN, EU, INTERPOL, PEP
    matched_name                   VARCHAR(100)    NOT NULL                                                 , -- Name on government sanction list
    match_score_pct                DECIMAL(5,2)    NOT NULL                                                 , -- Fuzzy logic match confidence %
    sanction_entity_id             VARCHAR(20)     NOT NULL                                                 , -- Global sanction entity code
    sanction_authority             VARCHAR(30)     NOT NULL                                                 , -- US_TREASURY, UN, EU_COMMISSION
    match_timestamp                TIMESTAMP       NOT NULL                                                 , -- Automated screening match time
    analyst_review_status          VARCHAR(25)     NOT NULL                                                 , -- UNDER_REVIEW, CLEARED, CONFIRMED
    review_decision                VARCHAR(30)     NOT NULL                                                 , -- FALSE_POSITIVE, BLOCK_TRANSACTION
    analyst_id                     INT             NOT NULL                                                 , -- Assigned sanction analyst ID
    clearance_reason               VARCHAR(150)    NOT NULL                                                 , -- Reason for clearing or blocking match
    entity_type                    VARCHAR(20)     NOT NULL                                                 , -- INDIVIDUAL, VESSEL, CORPORATION
    country_listed                 VARCHAR(3)      NOT NULL                                                 , -- Listed entity country ISO-3
    passport_match_flag            BOOLEAN         NOT NULL                                                 , -- Passport number exact match flag
    dob_match_flag                 BOOLEAN         NOT NULL                                                 , -- Date of birth match flag
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- RESOLVED, PENDING, BLOCKED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Screening system audit trail
);
