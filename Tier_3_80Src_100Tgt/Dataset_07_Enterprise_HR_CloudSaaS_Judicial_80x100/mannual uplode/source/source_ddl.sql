-- ========================================================
-- Master DDL Schema Script for Dataset_07_Enterprise_HR_CloudSaaS_Judicial_80x100_source
-- Tier: Tier 3: 80 Source Tables, 100 Target Tables
-- Total Tables: 80
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_03_Finance_Banking_Dataset, Dataset_04_HR_Payroll_Dataset, Dataset_11_Education_LMS_Dataset, Dataset_21_Judicial_Court_Management_Dataset, Dataset_25_SaaS_Subscription_App_Dataset
-- ========================================================

CREATE TABLE tbl_attendances (
    attendance_id                  INT             PRIMARY KEY                                                , -- Attendance entry primary key ID
    employee_id                    INT             NOT NULL                                                   , -- Employee ID
    work_date                      DATE            NOT NULL                                                   , -- Shift work date
    check_in_time                  TIMESTAMP       NOT NULL                                                   , -- Clock in timestamp
    check_out_time                 TIMESTAMP       NOT NULL                                                   , -- Clock out timestamp
    hours_worked                   DECIMAL(4,2)    NOT NULL                                                   , -- Total regular hours worked
    overtime_hours                 DECIMAL(4,2)    NOT NULL                                                   , -- Total overtime hours worked
    status_code                    VARCHAR(15)     NOT NULL                                                     -- PRESENT/LATE/ABSENT
);

CREATE TABLE tbl_benefits (
    benefit_id                     INT             PRIMARY KEY                                                , -- Benefit enrollment primary key ID
    employee_id                    INT             NOT NULL REFERENCES tbl_employees(employee_id)             , -- Enrolled employee ID
    plan_name                      VARCHAR(50)     NOT NULL                                                   , -- Benefit plan designation
    benefit_type                   VARCHAR(25)     NOT NULL                                                   , -- HEALTH/DENTAL/VISION/401K
    employer_cost                  DECIMAL(8,2)    NOT NULL                                                   , -- Employer monthly contribution
    employee_cost                  DECIMAL(8,2)    NOT NULL                                                   , -- Employee monthly payroll deduction
    enrollment_date                DATE            NOT NULL                                                   , -- Benefit plan enrollment date
    status_code                    VARCHAR(15)     NOT NULL                                                     -- ENROLLED/CANCELLED
);

CREATE TABLE tbl_departments (
    department_id                  INT             PRIMARY KEY                                                , -- Department primary key ID
    dept_code                      VARCHAR(10)     NOT NULL                                                   , -- Unique department code
    dept_name                      VARCHAR(50)     NOT NULL                                                   , -- Department title name
    manager_id                     INT             NOT NULL                                                   , -- Managing employee ID
    location_id                    INT             NOT NULL                                                   , -- Office location ID
    budget_amount                  DECIMAL(12,2)   NOT NULL                                                   , -- Annual department budget
    is_active                      VARCHAR(1)      NOT NULL                                                     -- Active flag Y/N
);

CREATE TABLE tbl_employees (
    employee_id                    INT             PRIMARY KEY                                                , -- Employee primary key ID
    ssn_number                     VARCHAR(11)     NOT NULL                                                   , -- Social Security Number
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- Employee given first name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Employee family last name
    email_address                  VARCHAR(100)    NOT NULL                                                   , -- Corporate email address
    hire_date                      DATE            NOT NULL                                                   , -- Employment start date
    job_title                      VARCHAR(50)     NOT NULL                                                   , -- Assigned job title
    department_id                  INT             NOT NULL REFERENCES tbl_departments(department_id)         , -- Assigned department ID
    employment_status              VARCHAR(15)     NOT NULL                                                     -- ACTIVE/TERMINATED/LEAVE
);

CREATE TABLE tbl_job_positions (
    position_id                    INT             PRIMARY KEY                                                , -- Job position primary key ID
    position_code                  VARCHAR(10)     NOT NULL                                                   , -- Unique position code
    position_title                 VARCHAR(50)     NOT NULL                                                   , -- Standardized job title
    min_salary                     DECIMAL(10,2)   NOT NULL                                                   , -- Minimum salary band
    max_salary                     DECIMAL(10,2)   NOT NULL                                                   , -- Maximum salary band
    department_id                  INT             NOT NULL                                                   , -- Parent department ID
    status_code                    VARCHAR(10)     NOT NULL                                                     -- ACTIVE/OPEN/CLOSED
);

CREATE TABLE tbl_payrolls (
    payroll_id                     INT             PRIMARY KEY                                                , -- Payroll record primary key ID
    employee_id                    INT             NOT NULL REFERENCES tbl_employees(employee_id)             , -- Employee ID
    pay_period_start               DATE            NOT NULL                                                   , -- Pay cycle start date
    pay_period_end                 DATE            NOT NULL                                                   , -- Pay cycle end date
    gross_pay                      DECIMAL(10,2)   NOT NULL                                                   , -- Gross compensation pay
    net_pay                        DECIMAL(10,2)   NOT NULL                                                   , -- Net take-home pay
    tax_deductions                 DECIMAL(10,2)   NOT NULL                                                   , -- Total tax withholdings
    payment_date                   DATE            NOT NULL                                                   , -- Disbursement date
    status_code                    VARCHAR(15)     NOT NULL                                                     -- PROCESSED/PENDING
);

CREATE TABLE tbl_performance_reviews (
    review_id                      INT             PRIMARY KEY                                                , -- Performance review primary key ID
    employee_id                    INT             NOT NULL                                                   , -- Evaluated employee ID
    reviewer_id                    INT             NOT NULL                                                   , -- Reviewer manager employee ID
    review_period                  VARCHAR(10)     NOT NULL                                                   , -- Review cycle e.g. 2024-Q4
    performance_score              DECIMAL(3,2)    NOT NULL                                                   , -- Rating score 1.00 - 5.00
    review_date                    DATE            NOT NULL                                                   , -- Appraisal review date
    feedback_notes                 TEXT            NULL                                                       , -- Manager evaluation comments
    status_code                    VARCHAR(15)     NOT NULL                                                     -- COMPLETED/DRAFT
);

CREATE TABLE tbl_salaries (
    salary_id                      INT             PRIMARY KEY                                                , -- Salary record primary key ID
    employee_id                    INT             NOT NULL REFERENCES tbl_employees(employee_id)             , -- Employee ID
    base_salary                    DECIMAL(10,2)   NOT NULL                                                   , -- Annual base compensation
    currency_code                  VARCHAR(3)      NOT NULL                                                   , -- Salary currency USD
    effective_date                 DATE            NOT NULL                                                   , -- Salary start effective date
    end_date                       DATE            NULL                                                       , -- Salary change end date
    pay_frequency                  VARCHAR(15)     NOT NULL                                                   , -- BIWEEKLY/MONTHLY
    is_current                     VARCHAR(1)      NOT NULL                                                     -- Is current salary record Y/N
);

CREATE TABLE tbl_timeoff_requests (
    request_id                     INT             PRIMARY KEY                                                , -- Time-off request primary key ID
    employee_id                    INT             NOT NULL                                                   , -- Requesting employee ID
    leave_type                     VARCHAR(20)     NOT NULL                                                   , -- VACATION/SICK/PERSONAL/PARENTAL
    start_date                     DATE            NOT NULL                                                   , -- Leave start date
    end_date                       DATE            NOT NULL                                                   , -- Leave end date
    total_days                     DECIMAL(4,1)    NOT NULL                                                   , -- Total leave days requested
    approval_status                VARCHAR(15)     NOT NULL                                                   , -- APPROVED/PENDING/REJECTED
    requested_at                   TIMESTAMP       NOT NULL                                                     -- Submission timestamp
);

CREATE TABLE tbl_trainings (
    training_id                    INT             PRIMARY KEY                                                , -- Training record primary key ID
    employee_id                    INT             NOT NULL                                                   , -- Attending employee ID
    course_name                    VARCHAR(80)     NOT NULL                                                   , -- Training course title
    provider_name                  VARCHAR(50)     NOT NULL                                                   , -- Course provider organization
    completion_date                DATE            NOT NULL                                                   , -- Course completion date
    score_achieved                 INT             NOT NULL                                                   , -- Score percentage achieved
    certification_status           VARCHAR(15)     NOT NULL                                                     -- PASSED/FAILED/EXPIRED
);

CREATE TABLE tbl_api_keys (
    key_id                         INT             PRIMARY KEY                                                , -- API Key primary key ID
    tenant_id                      INT             NOT NULL REFERENCES tbl_tenant_organizations(tenant_id)    , -- FK to tbl_tenant_organizations
    api_key_hash                   VARCHAR(64)     NOT NULL                                                     -- SHA256 hashed secret key
);

CREATE TABLE tbl_feature_flags (
    flag_id                        INT             PRIMARY KEY                                                , -- Flag primary key ID
    flag_key                       VARCHAR(50)     NOT NULL                                                   , -- Feature toggle code
    is_enabled                     VARCHAR(1)      NOT NULL                                                     -- Enabled Y/N
);

CREATE TABLE tbl_saas_plans (
    plan_id                        INT             PRIMARY KEY                                                , -- Plan primary key ID
    plan_name                      VARCHAR(40)     NOT NULL                                                   , -- STARTER/PRO/ENTERPRISE
    monthly_seat_cost              DECIMAL(8,2)    NOT NULL                                                     -- Price per seat USD
);

CREATE TABLE tbl_tenant_organizations (
    tenant_id                      INT             PRIMARY KEY                                                , -- Tenant primary key ID
    company_name                   VARCHAR(100)    NOT NULL                                                   , -- B2B Client name
    domain_url                     VARCHAR(100)    NOT NULL                                                     -- Tenant domain slug
);

CREATE TABLE tbl_tenant_subscriptions (
    subscription_id                INT             PRIMARY KEY                                                , -- Subscription primary key ID
    tenant_id                      INT             NOT NULL REFERENCES tbl_tenant_organizations(tenant_id)    , -- FK to tbl_tenant_organizations
    plan_id                        INT             NOT NULL REFERENCES tbl_saas_plans(plan_id)                , -- FK to tbl_saas_plans
    seat_count                     INT             NOT NULL                                                   , -- Purchased user seats
    status                         VARCHAR(20)     NOT NULL                                                     -- ACTIVE/PAST_DUE/CANCELED
);

CREATE TABLE tbl_usage_metered_logs (
    log_id                         INT             PRIMARY KEY                                                , -- Log primary key ID
    tenant_id                      INT             NOT NULL REFERENCES tbl_tenant_organizations(tenant_id)    , -- FK to tbl_tenant_organizations
    api_calls_count                INT             NOT NULL                                                   , -- Daily API calls count
    log_date                       DATE            NOT NULL                                                     -- Usage date
);

CREATE TABLE tbl_users (
    user_id                        INT             PRIMARY KEY                                                , -- User primary key ID
    tenant_id                      INT             NOT NULL REFERENCES tbl_tenant_organizations(tenant_id)    , -- FK to tbl_tenant_organizations
    email                          VARCHAR(100)    NOT NULL                                                   , -- Corporate email
    role_title                     VARCHAR(30)     NOT NULL                                                     -- ADMIN/MEMBER/VIEWER
);

CREATE TABLE tbl_assignments (
    assignment_id                  INT             PRIMARY KEY                                                , -- Assignment primary key ID
    course_id                      INT             NOT NULL REFERENCES tbl_courses(course_id)                 , -- FK to tbl_courses
    assignment_title               VARCHAR(100)    NOT NULL                                                   , -- Title
    max_points                     INT             NOT NULL                                                     -- Maximum possible points
);

CREATE TABLE tbl_course_materials (
    material_id                    INT             PRIMARY KEY                                                , -- Material primary key ID
    course_id                      INT             NOT NULL REFERENCES tbl_courses(course_id)                 , -- FK to tbl_courses
    material_title                 VARCHAR(100)    NOT NULL                                                   , -- Material title
    file_url                       VARCHAR(255)    NOT NULL                                                     -- Document URL
);

CREATE TABLE tbl_courses (
    course_id                      INT             PRIMARY KEY                                                , -- Course primary key ID
    course_code                    VARCHAR(15)     NOT NULL                                                   , -- Course catalog code (CS101)
    course_title                   VARCHAR(100)    NOT NULL                                                   , -- Full course title
    instructor_id                  INT             NOT NULL REFERENCES tbl_instructors(instructor_id)         , -- FK to tbl_instructors
    credit_hours                   INT             NOT NULL                                                     -- Academic credits
);

CREATE TABLE tbl_departments_education (
    department_id                  INT             PRIMARY KEY                                                , -- Department primary key ID
    dept_name                      VARCHAR(80)     NOT NULL                                                   , -- Academic department title
    faculty_head                   VARCHAR(60)     NOT NULL                                                     -- Department dean
);

CREATE TABLE tbl_enrollments (
    enrollment_id                  INT             PRIMARY KEY                                                , -- Enrollment primary key ID
    course_id                      INT             NOT NULL REFERENCES tbl_courses(course_id)                 , -- FK to tbl_courses
    student_id                     INT             NOT NULL REFERENCES tbl_students(student_id)               , -- FK to tbl_students
    enrollment_date                DATE            NOT NULL                                                   , -- Registration date
    final_grade                    VARCHAR(2)      NULL                                                         -- Letter grade (A/B/C)
);

CREATE TABLE tbl_instructors (
    instructor_id                  INT             PRIMARY KEY                                                , -- Instructor primary key ID
    department_id                  INT             NOT NULL REFERENCES tbl_departments(department_id)         , -- FK to tbl_departments
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- First name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Last name
    email                          VARCHAR(100)    NOT NULL                                                     -- Faculty email
);

CREATE TABLE tbl_students (
    student_id                     INT             PRIMARY KEY                                                , -- Student primary key ID
    student_number                 VARCHAR(20)     NOT NULL                                                   , -- University student ID
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- First name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Last name
    gpa                            DECIMAL(3,2)    NOT NULL                                                     -- Cumulative GPA
);

CREATE TABLE tbl_submissions (
    submission_id                  INT             PRIMARY KEY                                                , -- Submission primary key ID
    assignment_id                  INT             NOT NULL REFERENCES tbl_assignments(assignment_id)         , -- FK to tbl_assignments
    student_id                     INT             NOT NULL REFERENCES tbl_students(student_id)               , -- FK to tbl_students
    score_earned                   INT             NOT NULL                                                   , -- Grade points earned
    submitted_at                   TIMESTAMP       NOT NULL                                                     -- Turn in timestamp
);

CREATE TABLE tbl_attorneys_lawyers (
    attorney_id                    INT             PRIMARY KEY                                              , -- Attorney primary key ID
    license_number                 VARCHAR(20)     NOT NULL                                                 , -- Legal license bar number
    first_name                     VARCHAR(50)     NOT NULL                                                 , -- Attorney first name
    last_name                      VARCHAR(50)     NOT NULL                                                 , -- Attorney last name
    firm_name                      VARCHAR(100)    NOT NULL                                                 , -- Law firm or Public Defender office
    attorney_type                  VARCHAR(30)     NOT NULL                                                 , -- PROSECUTOR, DEFENSE, PUBLIC_DEFENDER, CORPORATE
    bar_admission_year             INT             NOT NULL                                                 , -- Year admitted to bar
    specialty_area                 VARCHAR(40)     NOT NULL                                                 , -- Criminal Defense, Corporate, Tax, Family
    phone_contact                  VARCHAR(20)     NOT NULL                                                 , -- Office phone contact
    email_address                  VARCHAR(100)    NOT NULL                                                 , -- Professional email address
    office_address                 VARCHAR(150)    NOT NULL                                                 , -- Law firm office address
    billing_hourly_rate_usd        DECIMAL(8,2)    NOT NULL                                                 , -- Billing rate per hour USD
    cases_handled_count            INT             NOT NULL                                                 , -- Total cases represented
    win_rate_percentage            DECIMAL(5,2)    NOT NULL                                                 , -- Case success rate percentage
    disciplinary_actions_count     INT             NOT NULL                                                 , -- Count of bar complaints/actions
    active_status                  BOOLEAN         NOT NULL                                                 , -- Active license status
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    district_code                  VARCHAR(10)     NOT NULL                                                 , -- Primary district code
    ratings_score                  DECIMAL(3,1)    NOT NULL                                                   -- Peer review rating out of 5.0
);

CREATE TABLE tbl_case_evidence (
    evidence_id                    INT             PRIMARY KEY                                              , -- Evidence primary key ID
    case_id                        INT             NOT NULL REFERENCES tbl_court_cases(case_id)         , -- FK to tbl_court_cases
    evidence_code                  VARCHAR(20)     NOT NULL                                                 , -- Barcode or evidence code
    evidence_type                  VARCHAR(40)     NOT NULL                                                 , -- DOCUMENT, DNA, WEAPON, DIGITAL, PHOTO
    description                    VARCHAR(200)    NOT NULL                                                 , -- Detailed evidence description
    date_collected                 DATE            NOT NULL                                                 , -- Date evidence was seized/collected
    collected_by_officer_id        INT             NOT NULL                                                 , -- Officer/investigator ID
    storage_location               VARCHAR(50)     NOT NULL                                                 , -- Locker or vault storage unit
    chain_of_custody_status        VARCHAR(30)     NOT NULL                                                 , -- VERIFIED, IN_TRANSIT, IN_LAB
    is_dna_evidence                BOOLEAN         NOT NULL                                                 , -- DNA evidence flag
    is_digital_evidence            BOOLEAN         NOT NULL                                                 , -- Digital forensic flag
    fingerprint_match_status       VARCHAR(20)     NOT NULL                                                 , -- MATCHED, UNMATCHED, INCONCLUSIVE
    lab_report_number              VARCHAR(20)     NOT NULL                                                 , -- Crime lab analysis report ID
    admissibility_status           VARCHAR(30)     NOT NULL                                                 , -- ADMISSIBLE, SUPPRESSED, CHALLENGED
    submitting_party               VARCHAR(30)     NOT NULL                                                 , -- PROSECUTION, DEFENSE, COURT
    file_attachment_size_mb        DECIMAL(8,2)    NOT NULL                                                 , -- Digital file size in MB
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    evidence_hash                  VARCHAR(64)     NOT NULL                                                 , -- SHA-256 digital hash verification
    security_level                 VARCHAR(15)     NOT NULL                                                   -- RESTRICTED, CONFIDENTIAL, PUBLIC
);

CREATE TABLE tbl_court_cases (
    case_id                        INT             PRIMARY KEY                                              , -- Court case primary key ID
    case_number                    VARCHAR(20)     NOT NULL                                                 , -- Official court case filing number
    court_jurisdiction             VARCHAR(50)     NOT NULL                                                 , -- District or federal jurisdiction
    case_type                      VARCHAR(40)     NOT NULL                                                 , -- Civil, Criminal, Family, or Probate
    filing_date                    DATE            NOT NULL                                                 , -- Case official filing date
    plaintiff_name                 VARCHAR(100)    NOT NULL                                                 , -- Name of plaintiff or prosecutor
    defendant_name                 VARCHAR(100)    NOT NULL                                                 , -- Name of defendant entity or person
    presiding_judge_id             INT             NOT NULL REFERENCES tbl_judges_magistrates(judge_id) , -- FK to tbl_judges_magistrates
    assigned_attorney_id           INT             NOT NULL REFERENCES tbl_attorneys_lawyers(attorney_id), -- FK to tbl_attorneys_lawyers
    courtroom_number               VARCHAR(10)     NOT NULL                                                 , -- Assigned courtroom number
    case_status                    VARCHAR(30)     NOT NULL                                                 , -- PENDING, IN_TRIAL, DISPOSED, APPEALED
    bail_amount_usd                DECIMAL(10,2)   NOT NULL                                                 , -- Bail or bond amount set USD
    verdict_status                 VARCHAR(30)     NOT NULL                                                 , -- GUILTY, NOT_GUILTY, SETTLED, NONE
    hearing_count                  INT             NOT NULL                                                 , -- Total number of hearings held
    statute_code                   VARCHAR(20)     NOT NULL                                                 , -- Legal statute or penal code reference
    claim_amount_usd               DECIMAL(12,2)   NOT NULL                                                 , -- Financial damages or claim amount
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record last update timestamp
    district_code                  VARCHAR(10)     NOT NULL                                                 , -- Judicial district code
    is_appealed                    BOOLEAN         NOT NULL                                                 , -- Whether case was appealed
    priority_level                 VARCHAR(15)     NOT NULL                                                 , -- HIGH, MEDIUM, LOW, URGENT
    case_summary_notes             VARCHAR(255)    NOT NULL                                                   -- Summary notes of court proceedings
);

CREATE TABLE tbl_court_hearings (
    hearing_id                     INT             PRIMARY KEY                                              , -- Hearing primary key ID
    case_id                        INT             NOT NULL REFERENCES tbl_court_cases(case_id)         , -- FK to tbl_court_cases
    hearing_number                 INT             NOT NULL                                                 , -- Sequential hearing number for case
    scheduled_date                 DATE            NOT NULL                                                 , -- Scheduled hearing date
    actual_start_time              TIMESTAMP       NOT NULL                                                 , -- Hearing start timestamp
    actual_end_time                TIMESTAMP       NOT NULL                                                 , -- Hearing end timestamp
    judge_id                       INT             NOT NULL REFERENCES tbl_judges_magistrates(judge_id) , -- FK to tbl_judges_magistrates
    hearing_type                   VARCHAR(40)     NOT NULL                                                 , -- ARRAIGNMENT, MOTION, TRIAL, SENTENCING
    courtroom_code                 VARCHAR(10)     NOT NULL                                                 , -- Courtroom identifier
    hearing_outcome                VARCHAR(50)     NOT NULL                                                 , -- Outcome or order issued
    is_public_proceeding           BOOLEAN         NOT NULL                                                 , -- Whether public attendance is allowed
    stenographer_name              VARCHAR(100)    NOT NULL                                                 , -- Official court reporter name
    transcript_page_count          INT             NOT NULL                                                 , -- Number of transcript pages
    next_hearing_date              DATE            NOT NULL                                                 , -- Next scheduled hearing date
    bail_decision                  VARCHAR(30)     NOT NULL                                                 , -- MAINTAINED, INCREASED, REVOKED, GRANTED
    contempt_citation_count        INT             NOT NULL                                                 , -- Count of contempt citations issued
    evidence_presented_count       INT             NOT NULL                                                 , -- Number of evidence items presented
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    hearing_status                 VARCHAR(20)     NOT NULL                                                   -- COMPLETED, ADJOURNED, CANCELLED
);

CREATE TABLE tbl_judges_magistrates (
    judge_id                       INT             PRIMARY KEY                                              , -- Judge primary key ID
    judge_code                     VARCHAR(15)     NOT NULL                                                 , -- Official judicial badge/code
    first_name                     VARCHAR(50)     NOT NULL                                                 , -- Judge first name
    last_name                      VARCHAR(50)     NOT NULL                                                 , -- Judge last name
    appointment_date               DATE            NOT NULL                                                 , -- Date of judicial appointment
    jurisdiction_district          VARCHAR(50)     NOT NULL                                                 , -- District jurisdiction area
    court_level                    VARCHAR(30)     NOT NULL                                                 , -- MAGISTRATE, DISTRICT, APPELLATE, SUPREME
    specialization                 VARCHAR(40)     NOT NULL                                                 , -- CRIMINAL, CIVIL, CONSTITUTIONAL, COMMERCIAL
    bar_association_number         VARCHAR(20)     NOT NULL                                                 , -- State Bar license number
    total_cases_tried              INT             NOT NULL                                                 , -- Lifetime total cases tried
    active_status                  BOOLEAN         NOT NULL                                                 , -- Active judicial status
    salary_amount_usd              DECIMAL(10,2)   NOT NULL                                                 , -- Annual judicial salary USD
    office_room_number             VARCHAR(10)     NOT NULL                                                 , -- Chambers room number
    email_address                  VARCHAR(100)    NOT NULL                                                 , -- Judicial email contact
    phone_number                   VARCHAR(20)     NOT NULL                                                 , -- Chambers direct phone
    years_of_experience            INT             NOT NULL                                                 , -- Years on the bench
    education_degree               VARCHAR(50)     NOT NULL                                                 , -- Juris Doctor / Master of Laws
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    notes                          VARCHAR(200)    NOT NULL                                                   -- Judicial tenure notes
);

CREATE TABLE tbl_cart_items (
    cart_item_id                   INT             PRIMARY KEY                                                , -- Cart item primary key ID
    cart_id                        INT             NOT NULL REFERENCES tbl_shopping_carts(cart_id)            , -- FK to tbl_shopping_carts
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    quantity                       INT             NOT NULL                                                     -- Cart item count quantity
);

CREATE TABLE tbl_categories (
    category_id                    INT             PRIMARY KEY                                                , -- Category primary key ID
    category_name                  VARCHAR(50)     NOT NULL                                                   , -- Category display name
    category_slug                  VARCHAR(60)     NOT NULL                                                   , -- URL friendly slug
    parent_category_id             INT             NULL REFERENCES tbl_categories(category_id)                , -- Self-referencing parent category
    is_active                      VARCHAR(1)      NOT NULL                                                   , -- Active flag Y/N
    created_at                     TIMESTAMP       NOT NULL                                                     -- Record creation timestamp
);

CREATE TABLE tbl_customer_addresses (
    address_id                     INT             PRIMARY KEY                                                , -- Address primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    address_type                   VARCHAR(20)     NOT NULL                                                   , -- SHIPPING/BILLING
    street_address                 VARCHAR(100)    NOT NULL                                                   , -- Street address line
    city                           VARCHAR(50)     NOT NULL                                                   , -- City location
    state_code                     VARCHAR(5)      NOT NULL                                                   , -- State/province code
    postal_code                    VARCHAR(10)     NOT NULL                                                   , -- ZIP or Postal code
    country_code                   VARCHAR(3)      NOT NULL                                                     -- ISO 3-letter country code
);

CREATE TABLE tbl_customer_support_tickets (
    ticket_id                      INT             PRIMARY KEY                                                , -- Ticket primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    order_id                       INT             NULL REFERENCES tbl_orders(order_id)                       , -- FK to tbl_orders
    ticket_subject                 VARCHAR(100)    NOT NULL                                                   , -- Issue subject title
    ticket_status                  VARCHAR(20)     NOT NULL                                                   , -- OPEN/RESOLVED/CLOSED
    created_at                     TIMESTAMP       NOT NULL                                                     -- Opened timestamp
);

CREATE TABLE tbl_customers (
    customer_id                    INT             PRIMARY KEY                                                , -- Customer primary key ID
    customer_code                  VARCHAR(36)     NOT NULL                                                   , -- Unique tracking code
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- Given first name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Family last name
    email                          VARCHAR(100)    NOT NULL                                                   , -- Contact email address
    phone                          VARCHAR(20)     NULL                                                       , -- Telephone contact number
    account_status                 VARCHAR(20)     NOT NULL                                                   , -- ACTIVE/SUSPENDED/CLOSED
    customer_segment               VARCHAR(30)     NOT NULL                                                   , -- RETAIL/WHOLESALE/VIP
    total_spent                    DECIMAL(10,2)   NOT NULL                                                   , -- Lifetime spend amount
    loyalty_points                 INT             NOT NULL                                                   , -- Earned loyalty points
    is_active                      VARCHAR(1)      NOT NULL                                                   , -- Active flag Y/N
    created_at                     TIMESTAMP       NOT NULL                                                   , -- Account creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                     -- Account updated timestamp
);

CREATE TABLE tbl_discounts_promos (
    promo_id                       INT             PRIMARY KEY                                                , -- Promo primary key ID
    promo_code                     VARCHAR(20)     NOT NULL                                                   , -- Unique promo code
    discount_percent               DECIMAL(5,2)    NOT NULL                                                   , -- Discount percentage rate
    start_date                     DATE            NOT NULL                                                   , -- Campaign start date
    end_date                       DATE            NOT NULL                                                   , -- Campaign expiry date
    is_active                      VARCHAR(1)      NOT NULL                                                     -- Active flag Y/N
);

CREATE TABLE tbl_inventory (
    inventory_id                   INT             PRIMARY KEY                                                , -- Inventory record primary key ID
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    warehouse_id                   INT             NOT NULL REFERENCES tbl_warehouses(warehouse_id)           , -- FK to tbl_warehouses
    quantity_on_hand               INT             NOT NULL                                                   , -- Available physical stock
    reserved_quantity              INT             NOT NULL                                                   , -- Allocated pending order stock
    last_updated                   TIMESTAMP       NOT NULL                                                     -- Stock check timestamp
);

CREATE TABLE tbl_invoices (
    invoice_id                     INT             PRIMARY KEY                                                , -- Invoice primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_orders(order_id)                   , -- FK to tbl_orders
    invoice_number                 VARCHAR(30)     NOT NULL                                                   , -- Tax invoice document number
    invoice_date                   DATE            NOT NULL                                                   , -- Billing issue date
    due_date                       DATE            NOT NULL                                                   , -- Payment due date
    total_amount                   DECIMAL(10,2)   NOT NULL                                                   , -- Total billed amount
    invoice_status                 VARCHAR(15)     NOT NULL                                                     -- PAID/UNPAID/OVERDUE
);

CREATE TABLE tbl_order_items (
    order_item_id                  INT             PRIMARY KEY                                                , -- Order line item primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_orders(order_id)                   , -- FK to tbl_orders
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    unit_price                     DECIMAL(10,2)   NOT NULL                                                   , -- Sold price per unit
    quantity                       INT             NOT NULL                                                   , -- Purchased item quantity
    subtotal                       DECIMAL(10,2)   NOT NULL                                                     -- Calculated line item subtotal
);

CREATE TABLE tbl_orders (
    order_id                       INT             PRIMARY KEY                                                , -- Order primary key ID
    order_number                   VARCHAR(36)     NOT NULL                                                   , -- Unique transaction order number
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    order_date                     TIMESTAMP       NOT NULL                                                   , -- Order placement timestamp
    order_status                   VARCHAR(20)     NOT NULL                                                   , -- PENDING/PROCESSING/SHIPPED/DELIVERED/CANCELLED
    total_amount                   DECIMAL(10,2)   NOT NULL                                                   , -- Gross order total
    tax_amount                     DECIMAL(10,2)   NOT NULL                                                   , -- Applied tax amount
    shipping_fee                   DECIMAL(10,2)   NOT NULL                                                   , -- Shipping charge fee
    created_at                     TIMESTAMP       NOT NULL                                                     -- Record creation timestamp
);

CREATE TABLE tbl_payments (
    payment_id                     INT             PRIMARY KEY                                                , -- Payment primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_orders(order_id)                   , -- FK to tbl_orders
    payment_method                 VARCHAR(20)     NOT NULL                                                   , -- CREDIT_CARD/PAYPAL/WIRE
    payment_status                 VARCHAR(15)     NOT NULL                                                   , -- COMPLETED/PENDING/FAILED
    amount                         DECIMAL(10,2)   NOT NULL                                                   , -- Processed payment amount
    transaction_ref                VARCHAR(36)     NOT NULL                                                   , -- Gateway transaction reference
    payment_date                   TIMESTAMP       NOT NULL                                                     -- Execution timestamp
);

CREATE TABLE tbl_product_attributes (
    attribute_id                   INT             PRIMARY KEY                                                , -- Attribute primary key ID
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    attribute_name                 VARCHAR(50)     NOT NULL                                                   , -- Color/Size/Weight
    attribute_value                VARCHAR(50)     NOT NULL                                                     -- Attribute value string
);

CREATE TABLE tbl_product_reviews (
    review_id                      INT             PRIMARY KEY                                                , -- Review primary key ID
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    rating_score                   INT             NOT NULL                                                   , -- Rating 1-5 stars
    review_text                    TEXT            NULL                                                       , -- Customer feedback review
    created_at                     TIMESTAMP       NOT NULL                                                     -- Review submission timestamp
);

CREATE TABLE tbl_products (
    product_id                     INT             PRIMARY KEY                                                , -- Product primary key ID
    sku                            VARCHAR(30)     NOT NULL                                                   , -- Stock Keeping Unit SKU
    product_name                   VARCHAR(100)    NOT NULL                                                   , -- Product catalog title
    category_id                    INT             NOT NULL REFERENCES tbl_categories(category_id)            , -- FK to tbl_categories
    supplier_id                    INT             NOT NULL REFERENCES tbl_suppliers(supplier_id)             , -- FK to tbl_suppliers
    unit_price                     DECIMAL(10,2)   NOT NULL                                                   , -- Standard retail price
    cost_price                     DECIMAL(10,2)   NOT NULL                                                   , -- Wholesale cost price
    product_status                 VARCHAR(20)     NOT NULL                                                   , -- ACTIVE/DISCONTINUED/OUT_OF_STOCK
    created_at                     TIMESTAMP       NOT NULL                                                     -- Catalog entry timestamp
);

CREATE TABLE tbl_return_requests (
    return_id                      INT             PRIMARY KEY                                                , -- Return request primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_orders(order_id)                   , -- FK to tbl_orders
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    return_reason                  VARCHAR(100)    NOT NULL                                                   , -- Reason for return
    return_status                  VARCHAR(20)     NOT NULL                                                   , -- REQUESTED/APPROVED/REJECTED
    created_at                     TIMESTAMP       NOT NULL                                                     -- Request timestamp
);

CREATE TABLE tbl_shipments (
    shipment_id                    INT             PRIMARY KEY                                                , -- Shipment primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_orders(order_id)                   , -- FK to tbl_orders
    tracking_number                VARCHAR(40)     NOT NULL                                                   , -- Carrier tracking code
    carrier_name                   VARCHAR(30)     NOT NULL                                                   , -- UPS/FEDEX/DHL
    shipped_date                   TIMESTAMP       NULL                                                       , -- Dispatch timestamp
    delivery_date                  TIMESTAMP       NULL                                                       , -- Delivery timestamp
    shipment_status                VARCHAR(20)     NOT NULL                                                     -- IN_TRANSIT/DELIVERED/RETURNED
);

CREATE TABLE tbl_shopping_carts (
    cart_id                        INT             PRIMARY KEY                                                , -- Cart primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    created_at                     TIMESTAMP       NOT NULL                                                   , -- Cart creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                     -- Cart modified timestamp
);

CREATE TABLE tbl_suppliers (
    supplier_id                    INT             PRIMARY KEY                                                , -- Supplier primary key ID
    company_name                   VARCHAR(100)    NOT NULL                                                   , -- Supplier corporate name
    contact_name                   VARCHAR(60)     NOT NULL                                                   , -- Primary account manager
    email                          VARCHAR(100)    NOT NULL                                                   , -- Corporate email address
    phone                          VARCHAR(20)     NOT NULL                                                   , -- Corporate contact phone
    country_code                   VARCHAR(3)      NOT NULL                                                     -- ISO 3-letter country code
);

CREATE TABLE tbl_system_audit_logs (
    log_id                         INT             PRIMARY KEY                                                , -- Audit log primary key ID
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- Operator user string ID
    action_name                    VARCHAR(50)     NOT NULL                                                   , -- Action performed
    target_entity                  VARCHAR(50)     NOT NULL                                                   , -- Target table name
    created_at                     TIMESTAMP       NOT NULL                                                     -- Audit timestamp
);

CREATE TABLE tbl_warehouses (
    warehouse_id                   INT             PRIMARY KEY                                                , -- Warehouse primary key ID
    warehouse_code                 VARCHAR(20)     NOT NULL                                                   , -- Unique warehouse location code
    warehouse_name                 VARCHAR(80)     NOT NULL                                                   , -- Facility designation name
    city                           VARCHAR(50)     NOT NULL                                                   , -- Facility location city
    state_code                     VARCHAR(5)      NOT NULL                                                   , -- State/Province code
    country_code                   VARCHAR(3)      NOT NULL                                                     -- ISO 3-letter country code
);

CREATE TABLE tbl_wishlists (
    wishlist_id                    INT             PRIMARY KEY                                                , -- Wishlist primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    added_at                       TIMESTAMP       NOT NULL                                                     -- Addition timestamp
);

CREATE TABLE src_doctor_physicians (
    physician_id                   INT             PRIMARY KEY                                                , -- Physician primary key ID
    npi_number                     VARCHAR(10)     NOT NULL                                                   , -- National Provider Identifier NPI
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- Physician first name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Physician last name
    specialty                      VARCHAR(60)     NOT NULL                                                   , -- Medical specialty field
    department_id                  INT             NOT NULL REFERENCES src_hospital_departments(department_id) , -- FK to src_hospital_departments
    phone_contact                  VARCHAR(20)     NOT NULL                                                     -- Direct telephone contact
);

CREATE TABLE src_ehr_audit_logs (
    log_id                         INT             PRIMARY KEY                                                , -- Audit log primary key ID
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- Clinician user ID
    action_type                    VARCHAR(30)     NOT NULL                                                   , -- READ/WRITE/DELETE
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    ip_address                     VARCHAR(45)     NOT NULL                                                   , -- Workstation IP
    log_timestamp                  TIMESTAMP       NOT NULL                                                     -- Audit timestamp
);

CREATE TABLE src_emergency_contacts (
    contact_id                     INT             PRIMARY KEY                                                , -- Emergency contact primary key ID
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    contact_name                   VARCHAR(60)     NOT NULL                                                   , -- Contact person full name
    relationship                   VARCHAR(30)     NOT NULL                                                   , -- SPOUSE/PARENT/SIBLING
    phone_number                   VARCHAR(20)     NOT NULL                                                     -- Emergency phone number
);

CREATE TABLE src_hospital_departments (
    department_id                  INT             PRIMARY KEY                                                , -- Department primary key ID
    dept_name                      VARCHAR(60)     NOT NULL                                                   , -- Clinical department designation
    facility_name                  VARCHAR(80)     NOT NULL                                                   , -- Hospital facility complex
    building_location              VARCHAR(40)     NOT NULL                                                   , -- Building or floor wing
    phone_extension                VARCHAR(10)     NOT NULL                                                     -- Internal phone extension
);

CREATE TABLE src_hospital_encounters (
    encounter_id                   INT             PRIMARY KEY                                                , -- Encounter primary key ID
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    attending_physician_id         INT             NOT NULL REFERENCES src_doctor_physicians(physician_id)    , -- FK to src_doctor_physicians
    department_id                  INT             NOT NULL REFERENCES src_hospital_departments(department_id) , -- FK to src_hospital_departments
    encounter_class                VARCHAR(20)     NOT NULL                                                   , -- INPATIENT/OUTPATIENT/EMERGENCY
    admission_date                 TIMESTAMP       NOT NULL                                                   , -- Admission timestamp
    discharge_date                 TIMESTAMP       NULL                                                       , -- Discharge timestamp
    encounter_status               VARCHAR(15)     NOT NULL                                                     -- ACTIVE/FINISHED/CANCELLED
);

CREATE TABLE src_hospital_staff_roster (
    staff_id                       INT             PRIMARY KEY                                                , -- Staff primary key ID
    employee_number                VARCHAR(20)     NOT NULL                                                   , -- Staff badge ID
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Staff full name
    role_title                     VARCHAR(50)     NOT NULL                                                   , -- NURSE/TECHNICIAN/ADMIN
    department_id                  INT             NOT NULL REFERENCES src_hospital_departments(department_id) , -- FK to src_hospital_departments
    phone_extension                VARCHAR(10)     NOT NULL                                                     -- Internal phone extension
);

CREATE TABLE src_insurance_claims (
    claim_id                       INT             PRIMARY KEY                                                , -- Insurance claim primary key ID
    billing_id                     INT             NOT NULL REFERENCES src_patient_billing(billing_id)        , -- FK to src_patient_billing
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    payer_name                     VARCHAR(80)     NOT NULL                                                   , -- Health insurance provider
    claim_amount                   DECIMAL(10,2)   NOT NULL                                                   , -- Claimed reimbursement amount
    covered_amount                 DECIMAL(10,2)   NOT NULL                                                   , -- Approved covered amount
    claim_status                   VARCHAR(15)     NOT NULL                                                   , -- SUBMITTED/PAID/DENIED
    submission_date                DATE            NOT NULL                                                     -- Payer filing date
);

CREATE TABLE src_lab_results (
    lab_result_id                  INT             PRIMARY KEY                                                , -- Lab result primary key ID
    lab_order_id                   INT             NOT NULL REFERENCES src_lab_test_orders(lab_order_id)      , -- FK to src_lab_test_orders
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    result_value                   DECIMAL(10,2)   NOT NULL                                                   , -- Quantitative lab measurement
    unit_of_measure                VARCHAR(20)     NOT NULL                                                   , -- Measurement unit (mg/dL)
    reference_range                VARCHAR(30)     NOT NULL                                                   , -- Normal reference range
    result_status                  VARCHAR(15)     NOT NULL                                                   , -- FINAL/PRELIMINARY
    result_date                    TIMESTAMP       NOT NULL                                                     -- Result timestamp
);

CREATE TABLE src_lab_test_orders (
    lab_order_id                   INT             PRIMARY KEY                                                , -- Lab order primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    ordering_physician_id          INT             NOT NULL REFERENCES src_doctor_physicians(physician_id)    , -- FK to src_doctor_physicians
    loinc_code                     VARCHAR(20)     NOT NULL                                                   , -- LOINC lab test concept code
    test_name                      VARCHAR(100)    NOT NULL                                                   , -- Lab panel test title
    order_date                     TIMESTAMP       NOT NULL                                                   , -- Order timestamp
    order_status                   VARCHAR(15)     NOT NULL                                                     -- ORDERED/COMPLETED/CANCELLED
);

CREATE TABLE src_medical_diagnoses (
    diagnosis_id                   INT             PRIMARY KEY                                                , -- Diagnosis primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    icd10_code                     VARCHAR(20)     NOT NULL                                                   , -- ICD-10 clinical diagnosis code
    diagnosis_name                 VARCHAR(100)    NOT NULL                                                   , -- Diagnosis description
    diagnosis_date                 DATE            NOT NULL                                                     -- Onset or diagnosis date
);

CREATE TABLE src_medical_history (
    history_id                     INT             PRIMARY KEY                                                , -- Medical history primary key ID
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    condition_name                 VARCHAR(100)    NOT NULL                                                   , -- Pre-existing medical condition
    onset_date                     DATE            NOT NULL                                                   , -- Condition onset date
    condition_status               VARCHAR(15)     NOT NULL                                                     -- ACTIVE/RESOLVED
);

CREATE TABLE src_medical_prescriptions (
    prescription_id                INT             PRIMARY KEY                                                , -- Prescription primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    prescribing_physician_id       INT             NOT NULL REFERENCES src_doctor_physicians(physician_id)    , -- FK to src_doctor_physicians
    rxnorm_code                    VARCHAR(20)     NOT NULL                                                   , -- RxNorm medication code
    medication_name                VARCHAR(100)    NOT NULL                                                   , -- Medication trade name
    dosage_instructions            VARCHAR(100)    NOT NULL                                                   , -- Dosage and frequency
    prescribed_date                DATE            NOT NULL                                                     -- Prescription order date
);

CREATE TABLE src_patient_appointments (
    appointment_id                 INT             PRIMARY KEY                                                , -- Appointment primary key ID
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    physician_id                   INT             NOT NULL REFERENCES src_doctor_physicians(physician_id)    , -- FK to src_doctor_physicians
    department_id                  INT             NOT NULL REFERENCES src_hospital_departments(department_id) , -- FK to src_hospital_departments
    appointment_time               TIMESTAMP       NOT NULL                                                   , -- Scheduled appointment timestamp
    appointment_status             VARCHAR(15)     NOT NULL                                                     -- SCHEDULED/COMPLETED/NO_SHOW
);

CREATE TABLE src_patient_billing (
    billing_id                     INT             PRIMARY KEY                                                , -- Patient billing primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    total_charge_amount            DECIMAL(10,2)   NOT NULL                                                   , -- Gross medical charge
    paid_amount                    DECIMAL(10,2)   NOT NULL                                                   , -- Settled payment amount
    balance_due                    DECIMAL(10,2)   NOT NULL                                                   , -- Outstanding invoice balance
    billing_date                   DATE            NOT NULL                                                   , -- Statement generation date
    billing_status                 VARCHAR(15)     NOT NULL                                                     -- BILLED/PAID/OVERDUE
);

CREATE TABLE src_patient_immunizations (
    immunization_id                INT             PRIMARY KEY                                                , -- Immunization primary key ID
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    vaccine_code                   VARCHAR(20)     NOT NULL                                                   , -- CVX vaccine code
    vaccine_name                   VARCHAR(100)    NOT NULL                                                   , -- Vaccine trade name
    administered_date              DATE            NOT NULL                                                   , -- Vaccination date
    dose_number                    INT             NOT NULL                                                     -- Dose sequence number
);

CREATE TABLE src_patient_master (
    patient_id                     INT             PRIMARY KEY                                                , -- Patient primary key ID
    mrn_number                     VARCHAR(30)     NOT NULL                                                   , -- Medical Record Number MRN
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- Patient given first name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Patient family last name
    gender_code                    VARCHAR(1)      NOT NULL                                                   , -- Administrative gender (M/F/U)
    date_of_birth                  DATE            NOT NULL                                                   , -- Patient birth date
    phone_contact                  VARCHAR(20)     NOT NULL                                                   , -- Primary telephone contact
    city                           VARCHAR(50)     NOT NULL                                                   , -- City location
    state_code                     VARCHAR(5)      NOT NULL                                                   , -- State/Province code
    created_at                     TIMESTAMP       NOT NULL                                                     -- EHR entry timestamp
);

CREATE TABLE src_patient_vitals_signs (
    vital_id                       INT             PRIMARY KEY                                                , -- Vital sign primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    vital_type                     VARCHAR(30)     NOT NULL                                                   , -- HEART_RATE/BP_SYSTOLIC/TEMP
    numeric_value                  DECIMAL(8,2)    NOT NULL                                                   , -- Measurement reading
    unit_of_measure                VARCHAR(20)     NOT NULL                                                   , -- Measurement unit
    recorded_time                  TIMESTAMP       NOT NULL                                                     -- Observation timestamp
);

CREATE TABLE src_pharmacy_inventory (
    inventory_id                   INT             PRIMARY KEY                                                , -- Pharmacy stock primary key ID
    ndc_code                       VARCHAR(20)     NOT NULL                                                   , -- National Drug Code NDC
    medication_name                VARCHAR(100)    NOT NULL                                                   , -- Medication trade name
    quantity_in_stock              INT             NOT NULL                                                   , -- Physical stock on hand
    reorder_level                  INT             NOT NULL                                                     -- Reorder threshold count
);

CREATE TABLE src_room_bed_allocations (
    allocation_id                  INT             PRIMARY KEY                                                , -- Bed allocation primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    room_number                    VARCHAR(20)     NOT NULL                                                   , -- Hospital room number
    bed_number                     VARCHAR(10)     NOT NULL                                                   , -- Bed location designation
    start_time                     TIMESTAMP       NOT NULL                                                   , -- Bed assignment start
    end_time                       TIMESTAMP       NULL                                                         -- Bed discharge time
);

CREATE TABLE src_surgical_procedures (
    procedure_id                   INT             PRIMARY KEY                                                , -- Procedure primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    surgeon_id                     INT             NOT NULL REFERENCES src_doctor_physicians(physician_id)    , -- FK to src_doctor_physicians
    cpt_code                       VARCHAR(20)     NOT NULL                                                   , -- CPT procedure medical code
    procedure_name                 VARCHAR(100)    NOT NULL                                                   , -- Surgical procedure title
    procedure_date                 DATE            NOT NULL                                                     -- Surgery execution date
);

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

CREATE TABLE tbl_customers_finance (
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
