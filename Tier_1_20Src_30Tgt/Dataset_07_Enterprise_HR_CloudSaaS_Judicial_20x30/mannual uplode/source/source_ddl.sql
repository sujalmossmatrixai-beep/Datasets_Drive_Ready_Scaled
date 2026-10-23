-- ========================================================
-- Master DDL Schema Script for Dataset_07_Enterprise_HR_CloudSaaS_Judicial_20x30_source
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 20
-- Domains Included: Dataset_04_HR_Payroll_Dataset, Dataset_11_Education_LMS_Dataset, Dataset_25_SaaS_Subscription_App_Dataset
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
