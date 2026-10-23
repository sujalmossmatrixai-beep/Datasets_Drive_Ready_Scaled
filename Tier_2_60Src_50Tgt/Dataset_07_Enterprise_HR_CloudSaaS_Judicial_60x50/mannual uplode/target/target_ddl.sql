-- ========================================================
-- Master DDL Schema Script for Dataset_07_Enterprise_HR_CloudSaaS_Judicial_60x50_target
-- Tier: Tier 2: 60 Source Tables, 50 Target Tables
-- Total Tables: 50
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_04_HR_Payroll_Dataset, Dataset_11_Education_LMS_Dataset, Dataset_21_Judicial_Court_Management_Dataset, Dataset_25_SaaS_Subscription_App_Dataset
-- ========================================================

CREATE TABLE dim_department (
    department_key                 BIGINT          PRIMARY KEY                                                , -- Department surrogate key
    source_dept_id                 INT             NOT NULL                                                   , -- Source department natural ID
    department_code                VARCHAR(10)     NOT NULL                                                   , -- Natural department code
    department_name                VARCHAR(50)     NOT NULL                                                   , -- Department name
    manager_employee_key           BIGINT          NOT NULL                                                   , -- Managing employee key
    location_key                   BIGINT          NOT NULL                                                   , -- Office location key
    annual_budget_usd              NUMERIC(12,2)   NOT NULL                                                   , -- Annual budget USD
    is_active                      BOOLEAN         NOT NULL                                                     -- Active boolean indicator
);

CREATE TABLE dim_employee (
    employee_key                   BIGINT          PRIMARY KEY                                                , -- Employee surrogate key
    source_employee_id             INT             NOT NULL                                                   , -- Source natural employee ID
    national_id                    VARCHAR(11)     NOT NULL                                                   , -- Masked national identity SSN
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Full employee name
    work_email                     VARCHAR(100)    NOT NULL                                                   , -- Corporate email address
    hire_date                      DATE            NOT NULL                                                   , -- Employment start date
    job_title                      VARCHAR(50)     NOT NULL                                                   , -- Standardized job title
    department_key                 BIGINT          NOT NULL REFERENCES dim_department(department_key)         , -- FK to dim_department
    employment_status_code         VARCHAR(15)     NOT NULL                                                     -- Employment status code
);

CREATE TABLE dim_job_positions (
    position_key                   BIGINT          PRIMARY KEY                                                , -- Position surrogate key
    position_code                  VARCHAR(10)     NOT NULL                                                   , -- Natural position code
    position_title                 VARCHAR(50)     NOT NULL                                                   , -- Position title name
    salary_grade_min               NUMERIC(10,2)   NOT NULL                                                   , -- Minimum salary USD
    salary_grade_max               NUMERIC(10,2)   NOT NULL                                                   , -- Maximum salary USD
    department_key                 BIGINT          NOT NULL                                                   , -- FK to dim_department
    position_status                VARCHAR(10)     NOT NULL                                                     -- Position status
);

CREATE TABLE fact_daily_attendance (
    attendance_key                 BIGINT          PRIMARY KEY                                                , -- Attendance surrogate key
    employee_key                   BIGINT          NOT NULL                                                   , -- FK to dim_employee
    shift_date                     DATE            NOT NULL                                                   , -- Work shift date
    clock_in_timestamp             TIMESTAMP       NOT NULL                                                   , -- Clock in ISO timestamp
    clock_out_timestamp            TIMESTAMP       NOT NULL                                                   , -- Clock out ISO timestamp
    total_worked_hours             NUMERIC(4,2)    NOT NULL                                                   , -- Total regular worked hours
    total_overtime_hours           NUMERIC(4,2)    NOT NULL                                                   , -- Total overtime worked hours
    attendance_status              VARCHAR(15)     NOT NULL                                                     -- Attendance status code
);

CREATE TABLE fact_employee_benefits (
    benefit_key                    BIGINT          PRIMARY KEY                                                , -- Benefit surrogate key
    employee_key                   BIGINT          NOT NULL REFERENCES dim_employee(employee_key)             , -- FK to dim_employee
    benefit_plan_name              VARCHAR(50)     NOT NULL                                                   , -- Benefit plan title
    benefit_category               VARCHAR(25)     NOT NULL                                                   , -- Benefit category code
    employer_contribution_usd      NUMERIC(8,2)    NOT NULL                                                   , -- Monthly employer cost USD
    employee_contribution_usd      NUMERIC(8,2)    NOT NULL                                                   , -- Monthly employee cost USD
    enrollment_date                DATE            NOT NULL                                                   , -- Plan enrollment date
    coverage_status                VARCHAR(15)     NOT NULL                                                     -- Coverage status
);

CREATE TABLE fact_payroll_disbursements (
    payroll_key                    BIGINT          PRIMARY KEY                                                , -- Payroll surrogate key
    employee_key                   BIGINT          NOT NULL REFERENCES dim_employee(employee_key)             , -- FK to dim_employee
    pay_period_start_date          DATE            NOT NULL                                                   , -- Pay period start date
    pay_period_end_date            DATE            NOT NULL                                                   , -- Pay period end date
    gross_pay_usd                  NUMERIC(10,2)   NOT NULL                                                   , -- Gross compensation pay USD
    net_pay_usd                    NUMERIC(10,2)   NOT NULL                                                   , -- Net take-home pay USD
    total_tax_deduction_usd        NUMERIC(10,2)   NOT NULL                                                   , -- Total tax withholdings USD
    disbursement_date              DATE            NOT NULL                                                   , -- Disbursement execution date
    payment_status                 VARCHAR(15)     NOT NULL                                                     -- Payment status code
);

CREATE TABLE fact_performance_appraisals (
    review_key                     BIGINT          PRIMARY KEY                                                , -- Performance review surrogate key
    employee_key                   BIGINT          NOT NULL                                                   , -- FK to dim_employee
    reviewer_employee_key          BIGINT          NOT NULL                                                   , -- Reviewer employee key
    appraisal_cycle                VARCHAR(10)     NOT NULL                                                   , -- Appraisal cycle period
    rating_score                   NUMERIC(3,2)    NOT NULL                                                   , -- Score decimal 1.00 - 5.00
    appraisal_date                 DATE            NOT NULL                                                   , -- Review date
    evaluation_notes               TEXT            NULL                                                       , -- Appraisal summary comments
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Review status
);

CREATE TABLE fact_salary_history (
    salary_key                     BIGINT          PRIMARY KEY                                                , -- Salary surrogate key
    employee_key                   BIGINT          NOT NULL REFERENCES dim_employee(employee_key)             , -- FK to dim_employee
    base_salary_usd                NUMERIC(10,2)   NOT NULL                                                   , -- Annual base salary USD
    currency_code                  VARCHAR(3)      NOT NULL                                                   , -- ISO currency code
    effective_date                 DATE            NOT NULL                                                   , -- Start effective date
    end_date                       DATE            NULL                                                       , -- End effective date
    pay_frequency_code             VARCHAR(15)     NOT NULL                                                   , -- Pay frequency code
    is_active_record               BOOLEAN         NOT NULL                                                     -- Current active salary record flag
);

CREATE TABLE fact_timeoff (
    timeoff_key                    BIGINT          PRIMARY KEY                                                , -- Timeoff surrogate key
    employee_key                   BIGINT          NOT NULL                                                   , -- FK to dim_employee
    leave_category                 VARCHAR(20)     NOT NULL                                                   , -- Leave category code
    start_date                     DATE            NOT NULL                                                   , -- Leave start date
    end_date                       DATE            NOT NULL                                                   , -- Leave end date
    duration_days                  NUMERIC(4,1)    NOT NULL                                                   , -- Duration in work days
    approval_status_code           VARCHAR(15)     NOT NULL                                                   , -- Approval status code
    request_timestamp              TIMESTAMP       NOT NULL                                                     -- Request timestamp ISO
);

CREATE TABLE fact_training_completions (
    training_key                   BIGINT          PRIMARY KEY                                                , -- Training completion surrogate key
    employee_key                   BIGINT          NOT NULL                                                   , -- FK to dim_employee
    course_title                   VARCHAR(80)     NOT NULL                                                   , -- Course title name
    training_provider              VARCHAR(50)     NOT NULL                                                   , -- Provider name
    completion_date                DATE            NOT NULL                                                   , -- Completion date
    final_score_pct                INT             NOT NULL                                                   , -- Score percentage
    certification_flag             BOOLEAN         NOT NULL                                                     -- Certification earned boolean flag
);

CREATE TABLE dim_saas_plan (
    plan_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_plan_id                 INT             NOT NULL                                                   , -- Natural ID
    plan_name                      VARCHAR(40)     NOT NULL                                                     -- Plan name
);

CREATE TABLE dim_tenant (
    tenant_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_tenant_id               INT             NOT NULL                                                   , -- Natural ID
    company_name                   VARCHAR(100)    NOT NULL                                                     -- Company name
);

CREATE TABLE fact_api_usage (
    usage_fact_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate key
    tenant_key                     BIGINT          NOT NULL REFERENCES dim_tenant(tenant_key)                 , -- FK to dim_tenant
    api_calls_count                INT             NOT NULL                                                     -- Call volume
);

CREATE TABLE fact_mrr_subscriptions (
    mrr_fact_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    tenant_key                     BIGINT          NOT NULL REFERENCES dim_tenant(tenant_key)                 , -- FK to dim_tenant
    plan_key                       BIGINT          NOT NULL REFERENCES dim_saas_plan(plan_key)                , -- FK to dim_saas_plan
    mrr_amount_usd                 NUMERIC(10,2)   NOT NULL                                                     -- Monthly recurring revenue USD
);

CREATE TABLE dim_course (
    course_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_course_id               INT             NOT NULL                                                   , -- Natural ID
    instructor_key                 BIGINT          NOT NULL REFERENCES dim_instructor(instructor_key)         , -- FK to dim_instructor
    course_code                    VARCHAR(15)     NOT NULL                                                   , -- Course code
    course_title                   VARCHAR(100)    NOT NULL                                                     -- Course title
);

CREATE TABLE dim_instructor (
    instructor_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_instructor_id           INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE dim_student (
    student_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_student_id              INT             NOT NULL                                                   , -- Natural ID
    student_number                 VARCHAR(20)     NOT NULL                                                   , -- Student ID number
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE fact_assignment_submission (
    submission_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate key
    course_key                     BIGINT          NOT NULL REFERENCES dim_course(course_key)                 , -- FK to dim_course
    student_key                    BIGINT          NOT NULL REFERENCES dim_student(student_key)               , -- FK to dim_student
    score_earned                   INT             NOT NULL                                                     -- Points earned
);

CREATE TABLE fact_enrollment (
    enrollment_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate key
    course_key                     BIGINT          NOT NULL REFERENCES dim_course(course_key)                 , -- FK to dim_course
    student_key                    BIGINT          NOT NULL REFERENCES dim_student(student_key)               , -- FK to dim_student
    final_grade_code               VARCHAR(2)      NULL                                                         -- Grade letter
);

CREATE TABLE dim_attorney (
    attorney_key                   BIGINT          PRIMARY KEY                                              , -- Surrogate key for attorney dimension
    source_attorney_id             INT             NOT NULL                                                 , -- Natural attorney ID from source
    license_number                 VARCHAR(20)     NOT NULL                                                 , -- License bar number
    full_name                      VARCHAR(100)    NOT NULL                                                 , -- Attorney full name
    law_firm_name                  VARCHAR(100)    NOT NULL                                                 , -- Firm or office name
    attorney_type                  VARCHAR(30)     NOT NULL                                                 , -- Attorney classification
    specialty_area                 VARCHAR(40)     NOT NULL                                                 , -- Legal specialty
    bar_admission_year             INT             NOT NULL                                                 , -- Bar admission year
    billing_hourly_rate_usd        NUMERIC(8,2)    NOT NULL                                                 , -- Hourly billing rate USD
    win_rate_percentage            NUMERIC(5,2)    NOT NULL                                                 , -- Win rate %
    cases_handled_count            INT             NOT NULL                                                 , -- Cases count
    office_address                 VARCHAR(150)    NOT NULL                                                 , -- Office street address
    district_code                  VARCHAR(10)     NOT NULL                                                 , -- District code
    peer_rating_score              NUMERIC(3,1)    NOT NULL                                                 , -- Peer score out of 5
    active_flag                    BOOLEAN         NOT NULL                                                 , -- Active flag
    email_contact                  VARCHAR(100)    NOT NULL                                                 , -- Email contact
    phone_contact                  VARCHAR(20)     NOT NULL                                                 , -- Phone contact
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_court_case (
    case_key                       BIGINT          PRIMARY KEY                                              , -- Surrogate key for case dimension
    source_case_id                 INT             NOT NULL                                                 , -- Natural case ID from source
    case_number                    VARCHAR(20)     NOT NULL                                                 , -- Case reference number
    jurisdiction_name              VARCHAR(50)     NOT NULL                                                 , -- Court jurisdiction name
    case_type_category             VARCHAR(40)     NOT NULL                                                 , -- Civil, Criminal, Family, Probate
    filing_date                    DATE            NOT NULL                                                 , -- Filing date dimension key
    plaintiff_full_name            VARCHAR(100)    NOT NULL                                                 , -- Plaintiff full name
    defendant_full_name            VARCHAR(100)    NOT NULL                                                 , -- Defendant full name
    courtroom_identifier           VARCHAR(10)     NOT NULL                                                 , -- Courtroom identifier
    statute_reference              VARCHAR(20)     NOT NULL                                                 , -- Statute code reference
    district_code                  VARCHAR(10)     NOT NULL                                                 , -- District code
    priority_level                 VARCHAR(15)     NOT NULL                                                 , -- Priority classification
    is_appealed_flag               BOOLEAN         NOT NULL                                                 , -- Is appealed indicator
    claim_amount_usd               NUMERIC(12,2)   NOT NULL                                                 , -- Claim amount USD
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_active_case                 BOOLEAN         NOT NULL                                                 , -- Active case flag
    effective_start_date           DATE            NOT NULL                                                 , -- SCD Type 2 effective start
    effective_end_date             DATE            NOT NULL                                                 , -- SCD Type 2 effective end
    is_current_record              BOOLEAN         NOT NULL                                                 , -- SCD Type 2 current flag
    summary_notes                  VARCHAR(255)    NOT NULL                                                 , -- Case summary text
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_judge (
    judge_key                      BIGINT          PRIMARY KEY                                              , -- Surrogate key for judge dimension
    source_judge_id                INT             NOT NULL                                                 , -- Natural judge ID from source
    judge_code                     VARCHAR(15)     NOT NULL                                                 , -- Judicial badge code
    full_name                      VARCHAR(100)    NOT NULL                                                 , -- Judge full name
    court_level                    VARCHAR(30)     NOT NULL                                                 , -- Judicial court rank
    specialization                 VARCHAR(40)     NOT NULL                                                 , -- Specialty domain
    jurisdiction_district          VARCHAR(50)     NOT NULL                                                 , -- District jurisdiction
    appointment_date               DATE            NOT NULL                                                 , -- Appointment date
    bar_number                     VARCHAR(20)     NOT NULL                                                 , -- Bar license number
    years_of_experience            INT             NOT NULL                                                 , -- Years of judicial service
    education_degree               VARCHAR(50)     NOT NULL                                                 , -- Degree qualification
    salary_amount_usd              NUMERIC(10,2)   NOT NULL                                                 , -- Salary USD
    active_status                  BOOLEAN         NOT NULL                                                 , -- Active status flag
    office_chambers                VARCHAR(10)     NOT NULL                                                 , -- Chambers room
    email_address                  VARCHAR(100)    NOT NULL                                                 , -- Email contact
    phone_contact                  VARCHAR(20)     NOT NULL                                                 , -- Phone contact
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_current                     BOOLEAN         NOT NULL                                                 , -- Current record flag
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_case_dispositions (
    disposition_key                BIGINT          PRIMARY KEY                                              , -- Surrogate key for disposition fact
    case_key                       BIGINT          NOT NULL REFERENCES dim_court_case(case_key)         , -- FK to dim_court_case
    judge_key                      BIGINT          NOT NULL REFERENCES dim_judge(judge_key)             , -- FK to dim_judge
    attorney_key                   BIGINT          NOT NULL REFERENCES dim_attorney(attorney_key)       , -- FK to dim_attorney
    disposition_date               DATE            NOT NULL                                                 , -- Case disposition date
    verdict_type                   VARCHAR(30)     NOT NULL                                                 , -- GUILTY, NOT_GUILTY, DISMISSED, SETTLED
    sentence_months                INT             NOT NULL                                                 , -- Incarceration sentence in months
    probation_months               INT             NOT NULL                                                 , -- Probation period in months
    fine_amount_usd                NUMERIC(10,2)   NOT NULL                                                 , -- Court fine amount USD
    restitution_amount_usd         NUMERIC(10,2)   NOT NULL                                                 , -- Victim restitution amount USD
    court_costs_usd                NUMERIC(8,2)    NOT NULL                                                 , -- Assessed court fees USD
    total_hearings_count           INT             NOT NULL                                                 , -- Total hearings prior to disposition
    case_duration_days             INT             NOT NULL                                                 , -- Days from filing to disposition
    is_appealed_flag               BOOLEAN         NOT NULL                                                 , -- Appeared flag
    district_code                  VARCHAR(10)     NOT NULL                                                 , -- District code
    statute_reference              VARCHAR(20)     NOT NULL                                                 , -- Statute reference
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    final_disposition_status       VARCHAR(20)     NOT NULL                                                 , -- CLOSED, APPEAL_PENDING, EXPUNGED
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_court_hearings (
    hearing_key                    BIGINT          PRIMARY KEY                                              , -- Surrogate key for hearing fact
    case_key                       BIGINT          NOT NULL REFERENCES dim_court_case(case_key)         , -- FK to dim_court_case
    judge_key                      BIGINT          NOT NULL REFERENCES dim_judge(judge_key)             , -- FK to dim_judge
    attorney_key                   BIGINT          NOT NULL REFERENCES dim_attorney(attorney_key)       , -- FK to dim_attorney
    hearing_number                 INT             NOT NULL                                                 , -- Hearing sequence number
    hearing_type                   VARCHAR(40)     NOT NULL                                                 , -- Hearing type text
    courtroom_code                 VARCHAR(10)     NOT NULL                                                 , -- Courtroom code
    scheduled_date                 DATE            NOT NULL                                                 , -- Scheduled date
    duration_minutes               INT             NOT NULL                                                 , -- Actual duration in minutes
    hearing_outcome                VARCHAR(50)     NOT NULL                                                 , -- Outcome ruling
    transcript_pages               INT             NOT NULL                                                 , -- Transcript page count
    evidence_count                 INT             NOT NULL                                                 , -- Evidence items count
    contempt_count                 INT             NOT NULL                                                 , -- Contempt citations count
    is_public_flag                 BOOLEAN         NOT NULL                                                 , -- Public proceeding flag
    bail_amount_usd                NUMERIC(10,2)   NOT NULL                                                 , -- Bail set USD
    hearing_status                 VARCHAR(20)     NOT NULL                                                 , -- Hearing status
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    district_code                  VARCHAR(10)     NOT NULL                                                 , -- District code
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
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

CREATE TABLE dim_customers (
    dim_cust_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_customer_id             INT             NOT NULL                                                   , -- Natural source ID
    customer_code                  VARCHAR(36)     NOT NULL                                                   , -- Tracking code
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Full customer name
    email_address                  VARCHAR(100)    NOT NULL                                                   , -- Email contact
    phone_number                   VARCHAR(20)     NULL                                                       , -- Phone number
    account_status                 VARCHAR(20)     NOT NULL                                                   , -- Status code
    is_active                      BOOLEAN         NOT NULL                                                   , -- Active indicator
    created_timestamp              TIMESTAMP       NOT NULL                                                     -- DW record timestamp
);

CREATE TABLE dim_product_attributes (
    dim_attr_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    attribute_name                 VARCHAR(50)     NOT NULL                                                   , -- Attribute name
    attribute_value                VARCHAR(50)     NOT NULL                                                     -- Attribute value
);

CREATE TABLE dim_products (
    dim_prod_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_product_id              INT             NOT NULL                                                   , -- Natural source ID
    sku                            VARCHAR(30)     NOT NULL                                                   , -- Product SKU
    product_name                   VARCHAR(100)    NOT NULL                                                   , -- Product title
    category_key                   BIGINT          NOT NULL REFERENCES dim_categories(dim_cat_key)            , -- FK to dim_categories
    supplier_key                   BIGINT          NOT NULL REFERENCES dim_suppliers(dim_supp_key)            , -- FK to dim_suppliers
    unit_price_usd                 NUMERIC(10,2)   NOT NULL                                                     -- Standard unit price
);

CREATE TABLE dim_promotions (
    dim_promo_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_promo_id                INT             NOT NULL                                                   , -- Natural source ID
    promo_code                     VARCHAR(20)     NOT NULL                                                   , -- Promo code
    discount_percent               NUMERIC(5,2)    NOT NULL                                                     -- Discount rate
);

CREATE TABLE dim_suppliers (
    dim_supp_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_supplier_id             INT             NOT NULL                                                   , -- Natural source ID
    company_name                   VARCHAR(100)    NOT NULL                                                   , -- Supplier company name
    country_code_iso2              VARCHAR(2)      NOT NULL                                                     -- ISO country code
);

CREATE TABLE dim_warehouses (
    dim_wh_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_warehouse_id            INT             NOT NULL                                                   , -- Natural source ID
    warehouse_code                 VARCHAR(20)     NOT NULL                                                   , -- Warehouse code
    warehouse_name                 VARCHAR(80)     NOT NULL                                                   , -- Warehouse name
    city_name                      VARCHAR(50)     NOT NULL                                                     -- Facility city
);

CREATE TABLE fact_audit_events (
    fact_audit_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- User string
    action_name                    VARCHAR(50)     NOT NULL                                                   , -- Action performed
    target_entity                  VARCHAR(50)     NOT NULL                                                     -- Target entity
);

CREATE TABLE fact_inventory_snapshot (
    fact_inv_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    warehouse_key                  BIGINT          NOT NULL REFERENCES dim_warehouses(dim_wh_key)             , -- FK to dim_warehouses
    quantity_on_hand               INT             NOT NULL                                                   , -- Physical stock count
    reserved_quantity              INT             NOT NULL                                                     -- Reserved stock count
);

CREATE TABLE fact_invoices (
    fact_invoice_key               BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    invoice_number                 VARCHAR(30)     NOT NULL                                                   , -- Invoice document number
    total_amount_usd               NUMERIC(12,2)   NOT NULL                                                     -- Billed total USD
);

CREATE TABLE fact_order_line_items (
    fact_item_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    unit_price_usd                 NUMERIC(10,2)   NOT NULL                                                   , -- Sold price USD
    quantity                       INT             NOT NULL                                                   , -- Unit count
    subtotal_usd                   NUMERIC(12,2)   NOT NULL                                                     -- Subtotal USD
);

CREATE TABLE fact_orders (
    fact_order_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_order_id                INT             NOT NULL                                                   , -- Natural source ID
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    order_number                   VARCHAR(36)     NOT NULL                                                   , -- Order number
    order_date                     TIMESTAMP       NOT NULL                                                   , -- Order date
    order_status                   VARCHAR(20)     NOT NULL                                                   , -- Order status
    total_amount_usd               NUMERIC(12,2)   NOT NULL                                                     -- Gross order total USD
);

CREATE TABLE fact_payments (
    fact_payment_key               BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    payment_method                 VARCHAR(20)     NOT NULL                                                   , -- Method name
    amount_usd                     NUMERIC(12,2)   NOT NULL                                                     -- Payment amount USD
);

CREATE TABLE fact_product_reviews (
    fact_review_key                BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    rating_score                   INT             NOT NULL                                                     -- Rating score 1-5
);

CREATE TABLE fact_return_requests (
    fact_return_key                BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    return_status                  VARCHAR(20)     NOT NULL                                                     -- Return status
);

CREATE TABLE fact_shipments (
    fact_shipment_key              BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    carrier_name                   VARCHAR(30)     NOT NULL                                                   , -- Carrier name
    tracking_number                VARCHAR(40)     NOT NULL                                                   , -- Tracking code
    shipment_status                VARCHAR(20)     NOT NULL                                                     -- Shipment status
);

CREATE TABLE fact_shopping_carts (
    fact_cart_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)              -- FK to dim_customers
);

CREATE TABLE fact_support_tickets (
    fact_ticket_key                BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    fact_order_key                 BIGINT          NULL REFERENCES fact_orders(fact_order_key)                , -- FK to fact_orders
    ticket_status                  VARCHAR(20)     NOT NULL                                                     -- Ticket status
);

CREATE TABLE fact_wishlists (
    fact_wishlist_key              BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)               -- FK to dim_products
);

CREATE TABLE fhir_account_billing (
    billing_account_key            BIGINT          PRIMARY KEY                                                , -- Billing account surrogate key
    source_billing_id              INT             NOT NULL                                                   , -- Source natural billing ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    encounter_key                  BIGINT          NOT NULL REFERENCES fhir_encounter(encounter_key)          , -- FK to fhir_encounter
    total_gross_charge_usd         NUMERIC(10,2)   NOT NULL                                                   , -- Gross medical charge USD
    amount_paid_usd                NUMERIC(10,2)   NOT NULL                                                   , -- Settled amount USD
    balance_usd                    NUMERIC(10,2)   NOT NULL                                                   , -- Balance due USD
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Account status
);

CREATE TABLE fhir_appointment (
    appointment_key                BIGINT          PRIMARY KEY                                                , -- Appointment surrogate key
    source_appointment_id          INT             NOT NULL                                                   , -- Source natural appointment ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    practitioner_key               BIGINT          NOT NULL REFERENCES fhir_practitioner(practitioner_key)    , -- FK to fhir_practitioner
    dept_key                       BIGINT          NOT NULL REFERENCES fhir_organization_dept(dept_key)       , -- FK to fhir_organization_dept
    start_timestamp                TIMESTAMP       NOT NULL                                                   , -- Scheduled start timestamp
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Appointment status
);

CREATE TABLE fhir_audit_event (
    audit_event_key                BIGINT          PRIMARY KEY                                                , -- Audit event surrogate key
    source_log_id                  INT             NOT NULL                                                   , -- Source natural log ID
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- Clinician user ID
    action_code                    VARCHAR(30)     NOT NULL                                                   , -- Action performed
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    event_timestamp                TIMESTAMP       NOT NULL                                                     -- Event ISO timestamp
);

CREATE TABLE fhir_claim (
    claim_key                      BIGINT          PRIMARY KEY                                                , -- Claim surrogate key
    source_claim_id                INT             NOT NULL                                                   , -- Source natural claim ID
    billing_account_key            BIGINT          NOT NULL REFERENCES fhir_account_billing(billing_account_key) , -- FK to fhir_account_billing
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    payer_name                     VARCHAR(80)     NOT NULL                                                   , -- Health insurance payer
    total_claimed_usd              NUMERIC(10,2)   NOT NULL                                                   , -- Claimed total USD
    total_covered_usd              NUMERIC(10,2)   NOT NULL                                                   , -- Approved covered USD
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Claim status
);

CREATE TABLE fhir_condition_diagnosis (
    condition_key                  BIGINT          PRIMARY KEY                                                , -- Condition surrogate key
    source_diagnosis_id            INT             NOT NULL                                                   , -- Source natural diagnosis ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    encounter_key                  BIGINT          NOT NULL REFERENCES fhir_encounter(encounter_key)          , -- FK to fhir_encounter
    icd10_code                     VARCHAR(20)     NOT NULL                                                   , -- ICD-10 clinical code
    condition_display              VARCHAR(100)    NOT NULL                                                   , -- Condition display title
    onset_date                     DATE            NOT NULL                                                     -- Condition onset date
);

CREATE TABLE fhir_encounter (
    encounter_key                  BIGINT          PRIMARY KEY                                                , -- Encounter surrogate key
    source_encounter_id            INT             NOT NULL                                                   , -- Source natural encounter ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    practitioner_key               BIGINT          NOT NULL REFERENCES fhir_practitioner(practitioner_key)    , -- FK to fhir_practitioner
    dept_key                       BIGINT          NOT NULL REFERENCES fhir_organization_dept(dept_key)       , -- FK to fhir_organization_dept
    encounter_class                VARCHAR(20)     NOT NULL                                                   , -- Encounter classification
    period_start                   TIMESTAMP       NOT NULL                                                   , -- Encounter period start
    period_end                     TIMESTAMP       NULL                                                       , -- Encounter period end
    status_code                    VARCHAR(15)     NOT NULL                                                     -- FHIR status code
);
