# Business Data Glossary - Dataset_07_Enterprise_HR_CloudSaaS_Judicial_20x30_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_07_Enterprise_HR_CloudSaaS_Judicial_20x30_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_07_Enterprise_HR_CloudSaaS_Judicial_20x30
- **Component**: Source Database Schema (Dataset_07_Enterprise_HR_CloudSaaS_Judicial_20x30_source)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Source Tables**: 20
- **Theme Focus**: Enterprise HR & Payroll, Cloud SaaS Subscriptions, LMS & Judicial Legal Systems
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

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

---

### Table: `tbl_salaries`
**Description**: Domain table for `tbl_salaries` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `salary_id` | **Salary Id** | `INT` | `PRIMARY KEY` | Salary record primary key ID |
| `employee_id` | **Employee Id** | `INT` | `FOREIGN KEY` | Employee ID |
| `base_salary` | **Base Salary** | `DECIMAL(10,2)` | `NOT NULL` | Annual base compensation |
| `currency_code` | **Currency Code** | `VARCHAR(3)` | `NOT NULL` | Salary currency USD |
| `effective_date` | **Effective Date** | `DATE` | `NOT NULL` | Salary start effective date |
| `end_date` | **End Date** | `DATE` | `NULL` | Salary change end date |
| `pay_frequency` | **Pay Frequency** | `VARCHAR(15)` | `NOT NULL` | BIWEEKLY/MONTHLY |
| `is_current` | **Is Current** | `VARCHAR(1)` | `NOT NULL` | Is current salary record Y/N |

---

---

### Table: `tbl_timeoff_requests`
**Description**: Domain table for `tbl_timeoff_requests` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `request_id` | **Request Id** | `INT` | `PRIMARY KEY` | Time-off request primary key ID |
| `employee_id` | **Employee Id** | `INT` | `NOT NULL` | Requesting employee ID |
| `leave_type` | **Leave Type** | `VARCHAR(20)` | `NOT NULL` | VACATION/SICK/PERSONAL/PARENTAL |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Leave start date |
| `end_date` | **End Date** | `DATE` | `NOT NULL` | Leave end date |
| `total_days` | **Total Days** | `DECIMAL(4,1)` | `NOT NULL` | Total leave days requested |
| `approval_status` | **Approval Status** | `VARCHAR(15)` | `NOT NULL` | APPROVED/PENDING/REJECTED |
| `requested_at` | **Requested At** | `TIMESTAMP` | `NOT NULL` | Submission timestamp |

---

---

### Table: `tbl_trainings`
**Description**: Domain table for `tbl_trainings` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `training_id` | **Training Id** | `INT` | `PRIMARY KEY` | Training record primary key ID |
| `employee_id` | **Employee Id** | `INT` | `NOT NULL` | Attending employee ID |
| `course_name` | **Course Name** | `VARCHAR(80)` | `NOT NULL` | Training course title |
| `provider_name` | **Provider Name** | `VARCHAR(50)` | `NOT NULL` | Course provider organization |
| `completion_date` | **Completion Date** | `DATE` | `NOT NULL` | Course completion date |
| `score_achieved` | **Score Achieved** | `INT` | `NOT NULL` | Score percentage achieved |
| `certification_status` | **Certification Status** | `VARCHAR(15)` | `NOT NULL` | PASSED/FAILED/EXPIRED |

---

---

### Table: `tbl_api_keys`
**Description**: Domain table for `tbl_api_keys` in `SaaS_Subscription_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `key_id` | **Key Id** | `INT` | `PRIMARY KEY` | API Key primary key ID |
| `tenant_id` | **Tenant Id** | `INT` | `FOREIGN KEY` | FK to tbl_tenant_organizations |
| `api_key_hash` | **Api Key Hash** | `VARCHAR(64)` | `NOT NULL` | SHA256 hashed secret key |

---

---

### Table: `tbl_feature_flags`
**Description**: Domain table for `tbl_feature_flags` in `SaaS_Subscription_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `flag_id` | **Flag Id** | `INT` | `PRIMARY KEY` | Flag primary key ID |
| `flag_key` | **Flag Key** | `VARCHAR(50)` | `NOT NULL` | Feature toggle code |
| `is_enabled` | **Is Enabled** | `VARCHAR(1)` | `NOT NULL` | Enabled Y/N |

---

---

### Table: `tbl_saas_plans`
**Description**: Domain table for `tbl_saas_plans` in `SaaS_Subscription_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `plan_id` | **Plan Id** | `INT` | `PRIMARY KEY` | Plan primary key ID |
| `plan_name` | **Plan Name** | `VARCHAR(40)` | `NOT NULL` | STARTER/PRO/ENTERPRISE |
| `monthly_seat_cost` | **Monthly Seat Cost** | `DECIMAL(8,2)` | `NOT NULL` | Price per seat USD |

---

---

### Table: `tbl_tenant_organizations`
**Description**: Domain table for `tbl_tenant_organizations` in `SaaS_Subscription_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tenant_id` | **Tenant Id** | `INT` | `PRIMARY KEY` | Tenant primary key ID |
| `company_name` | **Company Name** | `VARCHAR(100)` | `NOT NULL` | B2B Client name |
| `domain_url` | **Domain Url** | `VARCHAR(100)` | `NOT NULL` | Tenant domain slug |

---

---

### Table: `tbl_tenant_subscriptions`
**Description**: Domain table for `tbl_tenant_subscriptions` in `SaaS_Subscription_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `subscription_id` | **Subscription Id** | `INT` | `PRIMARY KEY` | Subscription primary key ID |
| `tenant_id` | **Tenant Id** | `INT` | `FOREIGN KEY` | FK to tbl_tenant_organizations |
| `plan_id` | **Plan Id** | `INT` | `FOREIGN KEY` | FK to tbl_saas_plans |
| `seat_count` | **Seat Count** | `INT` | `NOT NULL` | Purchased user seats |
| `status` | **Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE/PAST_DUE/CANCELED |

---

---

### Table: `tbl_usage_metered_logs`
**Description**: Domain table for `tbl_usage_metered_logs` in `SaaS_Subscription_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `log_id` | **Log Id** | `INT` | `PRIMARY KEY` | Log primary key ID |
| `tenant_id` | **Tenant Id** | `INT` | `FOREIGN KEY` | FK to tbl_tenant_organizations |
| `api_calls_count` | **Api Calls Count** | `INT` | `NOT NULL` | Daily API calls count |
| `log_date` | **Log Date** | `DATE` | `NOT NULL` | Usage date |

---

---

### Table: `tbl_users`
**Description**: Domain table for `tbl_users` in `SaaS_Subscription_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_id` | **User Id** | `INT` | `PRIMARY KEY` | User primary key ID |
| `tenant_id` | **Tenant Id** | `INT` | `FOREIGN KEY` | FK to tbl_tenant_organizations |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Corporate email |
| `role_title` | **Role Title** | `VARCHAR(30)` | `NOT NULL` | ADMIN/MEMBER/VIEWER |

---

---

### Table: `tbl_assignments`
**Description**: Domain table for `tbl_assignments` in `Education_LMS_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `assignment_id` | **Assignment Id** | `INT` | `PRIMARY KEY` | Assignment primary key ID |
| `course_id` | **Course Id** | `INT` | `FOREIGN KEY` | FK to tbl_courses |
| `assignment_title` | **Assignment Title** | `VARCHAR(100)` | `NOT NULL` | Title |
| `max_points` | **Max Points** | `INT` | `NOT NULL` | Maximum possible points |

---

---

### Table: `tbl_course_materials`
**Description**: Domain table for `tbl_course_materials` in `Education_LMS_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `material_id` | **Material Id** | `INT` | `PRIMARY KEY` | Material primary key ID |
| `course_id` | **Course Id** | `INT` | `FOREIGN KEY` | FK to tbl_courses |
| `material_title` | **Material Title** | `VARCHAR(100)` | `NOT NULL` | Material title |
| `file_url` | **File Url** | `VARCHAR(255)` | `NOT NULL` | Document URL |

---

---

### Table: `tbl_courses`
**Description**: Domain table for `tbl_courses` in `Education_LMS_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `course_id` | **Course Id** | `INT` | `PRIMARY KEY` | Course primary key ID |
| `course_code` | **Course Code** | `VARCHAR(15)` | `NOT NULL` | Course catalog code (CS101) |
| `course_title` | **Course Title** | `VARCHAR(100)` | `NOT NULL` | Full course title |
| `instructor_id` | **Instructor Id** | `INT` | `FOREIGN KEY` | FK to tbl_instructors |
| `credit_hours` | **Credit Hours** | `INT` | `NOT NULL` | Academic credits |

---