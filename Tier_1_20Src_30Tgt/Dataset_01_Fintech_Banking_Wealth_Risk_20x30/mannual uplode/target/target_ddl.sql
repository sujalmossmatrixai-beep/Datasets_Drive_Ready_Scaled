-- ========================================================
-- Master DDL Schema Script for Dataset_01_Fintech_Banking_Wealth_Risk_20x30_target
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 30
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_03_Finance_Banking_Dataset, Dataset_06_Asset_Management_Wealth_Dataset, Dataset_08_Banking_Fraud_Risk_Compliance_Dataset, Dataset_09_Cryptocurrency_Exchange_Dataset, Dataset_20_Insurance_Claims_Dataset
-- ========================================================

CREATE TABLE dim_accounts (
    account_key                    BIGINT          PRIMARY KEY                                                , -- Account surrogate key
    source_account_id              INT             NOT NULL                                                   , -- Source natural account ID
    account_number                 VARCHAR(20)     NOT NULL                                                   , -- Standardized account number
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(customer_key)            , -- FK to dim_customers
    account_type_name              VARCHAR(30)     NOT NULL                                                   , -- Account category name
    currency_code                  VARCHAR(3)      NOT NULL                                                   , -- ISO currency code
    is_active                      BOOLEAN         NOT NULL                                                   , -- Account active flag
    created_timestamp              TIMESTAMP       NOT NULL                                                     -- DW record creation timestamp
);

CREATE TABLE dim_branches (
    branch_key                     BIGINT          PRIMARY KEY                                                , -- Branch surrogate key
    branch_code                    VARCHAR(10)     NOT NULL                                                   , -- Natural branch code
    branch_name                    VARCHAR(60)     NOT NULL                                                   , -- Branch designation name
    full_address                   VARCHAR(150)    NOT NULL                                                   , -- Full street address
    city_name                      VARCHAR(50)     NOT NULL                                                   , -- City name
    state_province                 VARCHAR(50)     NOT NULL                                                   , -- State/province code
    postal_code                    VARCHAR(10)     NOT NULL                                                   , -- ZIP/Postal code
    manager_full_name              VARCHAR(60)     NOT NULL                                                   , -- Branch manager full name
    is_operational                 BOOLEAN         NOT NULL                                                     -- Operational boolean flag
);

CREATE TABLE dim_credit_cards (
    card_key                       BIGINT          PRIMARY KEY                                                , -- Credit card surrogate key
    account_key                    BIGINT          NOT NULL REFERENCES dim_accounts(account_key)              , -- FK to dim_accounts
    masked_card_number             VARCHAR(19)     NOT NULL                                                   , -- Masked card number
    card_brand                     VARCHAR(20)     NOT NULL                                                   , -- Card brand network
    credit_limit_usd               NUMERIC(10,2)   NOT NULL                                                   , -- Credit limit USD
    current_balance_usd            NUMERIC(10,2)   NOT NULL                                                   , -- Current balance USD
    expiry_date                    VARCHAR(7)      NOT NULL                                                   , -- Card expiry MM/YYYY
    is_active                      BOOLEAN         NOT NULL                                                     -- Active status indicator
);

CREATE TABLE dim_customers (
    customer_key                   BIGINT          PRIMARY KEY                                                , -- Customer surrogate key
    source_customer_id             INT             NOT NULL                                                   , -- Source natural customer ID
    ssn_tax_id                     VARCHAR(11)     NOT NULL                                                   , -- Masked tax identifier
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Full customer name
    primary_email                  VARCHAR(100)    NOT NULL                                                   , -- Standardized email address
    phone_number                   VARCHAR(20)     NOT NULL                                                   , -- Formatted contact phone
    kyc_status_name                VARCHAR(20)     NOT NULL                                                   , -- KYC compliance status
    risk_rating_code               VARCHAR(10)     NOT NULL                                                   , -- Risk tier classification
    is_current                     BOOLEAN         NOT NULL                                                     -- SCD Type 2 current record indicator
);

CREATE TABLE dim_portfolios (
    portfolio_key                  BIGINT          PRIMARY KEY                                                , -- Portfolio surrogate key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(customer_key)            , -- FK to dim_customers
    portfolio_name                 VARCHAR(60)     NOT NULL                                                   , -- Portfolio title name
    investment_strategy            VARCHAR(30)     NOT NULL                                                   , -- Investment strategy category
    total_portfolio_val_usd        NUMERIC(12,2)   NOT NULL                                                   , -- Total portfolio value USD
    risk_profile                   VARCHAR(15)     NOT NULL                                                   , -- Risk profile classification
    created_timestamp              TIMESTAMP       NOT NULL                                                   , -- Creation ISO timestamp
    is_active                      BOOLEAN         NOT NULL                                                     -- Active boolean flag
);

CREATE TABLE fact_audit_events (
    event_key                      BIGINT          PRIMARY KEY                                                , -- Audit event surrogate key
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- Operator user string
    action_category                VARCHAR(30)     NOT NULL                                                   , -- Action category name
    target_entity                  VARCHAR(40)     NOT NULL                                                   , -- Target domain entity
    entity_id                      INT             NOT NULL                                                   , -- Natural entity ID
    user_ip_address                VARCHAR(45)     NOT NULL                                                   , -- User IP address
    event_timestamp                TIMESTAMP       NOT NULL                                                   , -- Event ISO timestamp
    event_result                   VARCHAR(15)     NOT NULL                                                     -- Event outcome result
);

CREATE TABLE fact_loan_payments (
    payment_key                    BIGINT          PRIMARY KEY                                                , -- Loan payment surrogate key
    loan_key                       BIGINT          NOT NULL REFERENCES fact_loans(loan_key)                   , -- FK to fact_loans
    payment_timestamp              TIMESTAMP       NOT NULL                                                   , -- Payment execution timestamp
    principal_amount_paid          NUMERIC(10,2)   NOT NULL                                                   , -- Principal portion paid USD
    interest_amount_paid           NUMERIC(10,2)   NOT NULL                                                   , -- Interest portion paid USD
    total_amount_paid              NUMERIC(10,2)   NOT NULL                                                   , -- Total amount paid USD
    payment_channel                VARCHAR(20)     NOT NULL                                                   , -- Payment method channel
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Payment status
);

CREATE TABLE fact_loans (
    loan_key                       BIGINT          PRIMARY KEY                                                , -- Loan surrogate key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(customer_key)            , -- FK to dim_customers
    loan_type_code                 VARCHAR(20)     NOT NULL                                                   , -- Loan category code
    principal_amount_usd           NUMERIC(12,2)   NOT NULL                                                   , -- Disbursed principal amount USD
    annual_interest_rate           NUMERIC(5,2)    NOT NULL                                                   , -- Interest percentage rate
    term_months                    INT             NOT NULL                                                   , -- Loan term duration in months
    start_date                     DATE            NOT NULL                                                   , -- Loan start date
    remaining_balance_usd          NUMERIC(12,2)   NOT NULL                                                   , -- Current balance in USD
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Status code
);

CREATE TABLE fact_transactions (
    transaction_key                BIGINT          PRIMARY KEY                                                , -- Transaction surrogate key
    account_key                    BIGINT          NOT NULL REFERENCES dim_accounts(account_key)              , -- FK to dim_accounts
    transaction_ref                VARCHAR(36)     NOT NULL                                                   , -- Enterprise reference code
    txn_type                       VARCHAR(20)     NOT NULL                                                   , -- Transaction classification
    transaction_amount_usd         NUMERIC(12,2)   NOT NULL                                                   , -- Transaction amount in USD
    transaction_timestamp          TIMESTAMP       NOT NULL                                                   , -- Transaction ISO timestamp
    status_code                    VARCHAR(15)     NOT NULL                                                   , -- Standardized status code
    dim_date_key                   INT             NOT NULL                                                     -- Date key YYYYMMDD
);

CREATE TABLE fact_wire_transfers (
    transfer_key                   BIGINT          PRIMARY KEY                                                , -- Transfer surrogate key
    source_account_key             BIGINT          NOT NULL REFERENCES dim_accounts(account_key)              , -- FK to dim_accounts
    dest_account_number            VARCHAR(34)     NOT NULL                                                   , -- Destination account IBAN
    swift_bic_code                 VARCHAR(11)     NOT NULL                                                   , -- Destination SWIFT code
    transfer_amount_usd            NUMERIC(12,2)   NOT NULL                                                   , -- Transfer amount USD
    transfer_fee_usd               NUMERIC(8,2)    NOT NULL                                                   , -- Transfer fee USD
    transfer_timestamp             TIMESTAMP       NOT NULL                                                   , -- Transfer execution timestamp
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Status code
);

CREATE TABLE dim_client (
    client_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_client_id               INT             NOT NULL                                                   , -- Natural ID
    client_name                    VARCHAR(100)    NOT NULL                                                     -- Client name
);

CREATE TABLE dim_security (
    security_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_security_id             INT             NOT NULL                                                   , -- Natural ID
    ticker_symbol                  VARCHAR(10)     NOT NULL                                                     -- Ticker
);

CREATE TABLE fact_asset_transactions (
    transaction_key                BIGINT          PRIMARY KEY                                                , -- Surrogate key
    client_key                     BIGINT          NOT NULL REFERENCES dim_client(client_key)                 , -- FK to dim_client
    security_key                   BIGINT          NOT NULL REFERENCES dim_security(security_key)             , -- FK to dim_security
    total_amount_usd               NUMERIC(12,2)   NOT NULL                                                     -- Amount USD
);

CREATE TABLE fact_portfolio_holdings (
    holding_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    client_key                     BIGINT          NOT NULL REFERENCES dim_client(client_key)                 , -- FK to dim_client
    security_key                   BIGINT          NOT NULL REFERENCES dim_security(security_key)             , -- FK to dim_security
    shares_count                   NUMERIC(12,4)   NOT NULL                                                     -- Shares count
);

CREATE TABLE dim_account_compliance (
    account_key                    BIGINT          PRIMARY KEY                                              , -- Surrogate key for account dimension
    source_account_id              INT             NOT NULL                                                 , -- Natural account ID from source
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customer_risk(customer_key)  , -- FK to dim_customer_risk
    account_number                 VARCHAR(20)     NOT NULL                                                 , -- Account number string
    account_type                   VARCHAR(30)     NOT NULL                                                 , -- CHECKING, SAVINGS, CORPORATE, INVESTMENT
    currency_code                  VARCHAR(3)      NOT NULL                                                 , -- Currency ISO-3
    opening_date                   DATE            NOT NULL                                                 , -- Account opening date
    current_balance_usd            NUMERIC(14,2)   NOT NULL                                                 , -- Balance USD
    overdraft_limit_usd            NUMERIC(10,2)   NOT NULL                                                 , -- Overdraft limit USD
    account_status                 VARCHAR(20)     NOT NULL                                                 , -- ACTIVE, FROZEN, DORMANT, CLOSED
    branch_code                    VARCHAR(15)     NOT NULL                                                 , -- Bank branch code
    is_high_risk_flag              BOOLEAN         NOT NULL                                                 , -- High risk account flag
    aml_monitoring_status          VARCHAR(20)     NOT NULL                                                 , -- ACTIVE, ENHANCED, EXEMPT
    last_transaction_date          DATE            NOT NULL                                                 , -- Last active transaction date
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_current                     BOOLEAN         NOT NULL                                                 , -- Current record flag
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_customer_risk (
    customer_key                   BIGINT          PRIMARY KEY                                              , -- Surrogate key for customer risk dimension
    source_customer_id             INT             NOT NULL                                                 , -- Natural customer ID from source
    customer_number                VARCHAR(20)     NOT NULL                                                 , -- Customer number
    full_name                      VARCHAR(100)    NOT NULL                                                 , -- Full legal name
    date_of_birth                  DATE            NOT NULL                                                 , -- Birth date
    is_pep_flag                    BOOLEAN         NOT NULL                                                 , -- PEP flag
    sanctions_status               VARCHAR(25)     NOT NULL                                                 , -- Sanctions status text
    kyc_status                     VARCHAR(25)     NOT NULL                                                 , -- KYC status text
    kyc_updated_date               DATE            NOT NULL                                                 , -- KYC date
    risk_rating                    VARCHAR(15)     NOT NULL                                                 , -- Risk category rating
    credit_score                   INT             NOT NULL                                                 , -- Credit score
    annual_income_usd              NUMERIC(12,2)   NOT NULL                                                 , -- Annual income USD
    employment_status              VARCHAR(30)     NOT NULL                                                 , -- Employment status
    residence_country              VARCHAR(3)      NOT NULL                                                 , -- Country ISO-3
    tax_residence_country          VARCHAR(3)      NOT NULL                                                 , -- FATCA country
    active_account_count           INT             NOT NULL                                                 , -- Account count
    total_balance_usd              NUMERIC(14,2)   NOT NULL                                                 , -- Total balance USD
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- Customer status
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_current                     BOOLEAN         NOT NULL                                                 , -- SCD Type 2 current record flag
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_aml_reports (
    sar_fact_key                   BIGINT          PRIMARY KEY                                              , -- Surrogate key for SAR fact
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customer_risk(customer_key)  , -- FK to dim_customer_risk
    filing_date                    DATE            NOT NULL                                                 , -- Filing date key
    fincen_control_number          VARCHAR(25)     NOT NULL                                                 , -- Control number
    suspicious_activity_code       VARCHAR(25)     NOT NULL                                                 , -- Activity code
    suspicious_amount_usd          NUMERIC(12,2)   NOT NULL                                                 , -- Suspicious amount USD
    investigation_days             INT             NOT NULL                                                 , -- Days under investigation
    law_enforcement_flag           BOOLEAN         NOT NULL                                                 , -- Law enforcement notified flag
    account_frozen_flag            BOOLEAN         NOT NULL                                                 , -- Account frozen flag
    regulatory_body_code           VARCHAR(15)     NOT NULL                                                 , -- Regulatory body code
    jurisdiction_code              VARCHAR(10)     NOT NULL                                                 , -- Jurisdiction code
    approval_status                VARCHAR(20)     NOT NULL                                                 , -- Approval status
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_financial_transactions (
    transaction_key                BIGINT          PRIMARY KEY                                              , -- Surrogate key for transaction fact
    sender_customer_key            BIGINT          NOT NULL REFERENCES dim_customer_risk(customer_key)  , -- FK to dim_customer_risk
    receiver_customer_key          BIGINT          NOT NULL REFERENCES dim_customer_risk(customer_key)  , -- FK to dim_customer_risk
    sender_account_key             BIGINT          NOT NULL REFERENCES dim_account_compliance(account_key), -- FK to dim_account_compliance
    transaction_reference          VARCHAR(30)     NOT NULL                                                 , -- Transaction reference code
    transaction_timestamp          TIMESTAMP       NOT NULL                                                 , -- Timestamp key
    transaction_type               VARCHAR(30)     NOT NULL                                                 , -- Type text
    channel_type                   VARCHAR(20)     NOT NULL                                                 , -- Channel text
    principal_amount_usd           NUMERIC(12,2)   NOT NULL                                                 , -- Amount USD
    fee_amount_usd                 NUMERIC(8,2)    NOT NULL                                                 , -- Fee USD
    total_debit_usd                NUMERIC(12,2)   NOT NULL                                                 , -- Total debited USD
    risk_score_numeric             INT             NOT NULL                                                 , -- Risk score 1-100
    fraud_flag                     BOOLEAN         NOT NULL                                                 , -- Confirmed fraud flag
    cross_border_flag              BOOLEAN         NOT NULL                                                 , -- Cross border flag
    location_country               VARCHAR(3)      NOT NULL                                                 , -- Country ISO-3
    aml_status                     VARCHAR(25)     NOT NULL                                                 , -- AML status
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_fraud_alerts (
    alert_key                      BIGINT          PRIMARY KEY                                              , -- Surrogate key for alert fact
    transaction_key                BIGINT          NOT NULL REFERENCES fact_financial_transactions(transaction_key), -- FK to fact_financial_transactions
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customer_risk(customer_key)  , -- FK to dim_customer_risk
    alert_timestamp                TIMESTAMP       NOT NULL                                                 , -- Alert timestamp
    rule_code                      VARCHAR(20)     NOT NULL                                                 , -- Rule triggered code
    rule_name                      VARCHAR(80)     NOT NULL                                                 , -- Rule name text
    severity_level                 VARCHAR(15)     NOT NULL                                                 , -- Severity level
    anomaly_score                  INT             NOT NULL                                                 , -- Anomaly score 1-100
    investigation_status           VARCHAR(25)     NOT NULL                                                 , -- Status text
    resolution_outcome             VARCHAR(40)     NOT NULL                                                 , -- Resolution text
    is_false_positive_flag         BOOLEAN         NOT NULL                                                 , -- False positive flag
    sar_filed_flag                 BOOLEAN         NOT NULL                                                 , -- SAR filed flag
    confirmed_loss_usd             NUMERIC(10,2)   NOT NULL                                                 , -- Loss USD
    recovered_funds_usd            NUMERIC(10,2)   NOT NULL                                                 , -- Recovered USD
    investigation_hours            NUMERIC(5,1)    NOT NULL                                                 , -- Hours to resolve
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_asset (
    asset_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_asset_id                INT             NOT NULL                                                   , -- Natural ID
    ticker_symbol                  VARCHAR(10)     NOT NULL                                                     -- Ticker
);

CREATE TABLE dim_wallet (
    wallet_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_wallet_id               INT             NOT NULL                                                   , -- Natural ID
    asset_key                      BIGINT          NOT NULL REFERENCES dim_asset(asset_key)                     -- FK to dim_asset
);

CREATE TABLE fact_deposits (
    deposit_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    wallet_key                     BIGINT          NOT NULL REFERENCES dim_wallet(wallet_key)                 , -- FK to dim_wallet
    amount                         NUMERIC(18,8)   NOT NULL                                                     -- Amount
);

CREATE TABLE fact_executed_trades (
    trade_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    asset_key                      BIGINT          NOT NULL REFERENCES dim_asset(asset_key)                   , -- FK to dim_asset
    trade_volume                   NUMERIC(18,8)   NOT NULL                                                     -- Volume
);

CREATE TABLE dim_adjuster (
    adjuster_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_adjuster_id             INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE dim_policy (
    policy_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_policy_id               INT             NOT NULL                                                   , -- Natural ID
    policyholder_key               BIGINT          NOT NULL REFERENCES dim_policyholder(policyholder_key)     , -- FK to dim_policyholder
    policy_type                    VARCHAR(20)     NOT NULL                                                     -- Policy type
);

CREATE TABLE dim_policyholder (
    policyholder_key               BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_policyholder_id         INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE fact_claim_payouts (
    payout_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    claim_key                      BIGINT          NOT NULL REFERENCES fact_claim_submissions(claim_key)      , -- FK to fact_claim_submissions
    payout_amount_usd              NUMERIC(10,2)   NOT NULL                                                     -- Payout amount USD
);

CREATE TABLE fact_claim_submissions (
    claim_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    policy_key                     BIGINT          NOT NULL REFERENCES dim_policy(policy_key)                 , -- FK to dim_policy
    adjuster_key                   BIGINT          NOT NULL REFERENCES dim_adjuster(adjuster_key)             , -- FK to dim_adjuster
    claimed_amount_usd             NUMERIC(10,2)   NOT NULL                                                     -- Claimed amount USD
);

CREATE TABLE dim_categories (
    dim_cat_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_category_id             INT             NOT NULL                                                   , -- Natural source ID
    category_name                  VARCHAR(50)     NOT NULL                                                   , -- Category name
    parent_category_name           VARCHAR(50)     NULL                                                         -- Parent category name
);

CREATE TABLE dim_customer_addresses (
    dim_addr_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    address_type                   VARCHAR(20)     NOT NULL                                                   , -- Address classification
    city_name                      VARCHAR(50)     NOT NULL                                                   , -- City name
    state_province                 VARCHAR(50)     NOT NULL                                                   , -- State/Province
    country_code_iso2              VARCHAR(2)      NOT NULL                                                     -- Country code
);
