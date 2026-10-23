# Business Data Glossary - Dataset_07_Enterprise_HR_CloudSaaS_Judicial_80x100_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_07_Enterprise_HR_CloudSaaS_Judicial_80x100_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_07_Enterprise_HR_CloudSaaS_Judicial_80x100
- **Component**: Source Database Schema (Dataset_07_Enterprise_HR_CloudSaaS_Judicial_80x100_source)
- **Tier Specification**: Tier 3: 80 Source Tables, 100 Target Tables
- **Total Source Tables**: 80
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

---

### Table: `tbl_departments_education_education`
**Description**: Domain table for `tbl_departments_education` in `Education_LMS_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `department_id` | **Department Id** | `INT` | `PRIMARY KEY` | Department primary key ID |
| `dept_name` | **Dept Name** | `VARCHAR(80)` | `NOT NULL` | Academic department title |
| `faculty_head` | **Faculty Head** | `VARCHAR(60)` | `NOT NULL` | Department dean |

---

---

### Table: `tbl_enrollments`
**Description**: Domain table for `tbl_enrollments` in `Education_LMS_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `enrollment_id` | **Enrollment Id** | `INT` | `PRIMARY KEY` | Enrollment primary key ID |
| `course_id` | **Course Id** | `INT` | `FOREIGN KEY` | FK to tbl_courses |
| `student_id` | **Student Id** | `INT` | `FOREIGN KEY` | FK to tbl_students |
| `enrollment_date` | **Enrollment Date** | `DATE` | `NOT NULL` | Registration date |
| `final_grade` | **Final Grade** | `VARCHAR(2)` | `NULL` | Letter grade (A/B/C) |

---

---

### Table: `tbl_instructors`
**Description**: Domain table for `tbl_instructors` in `Education_LMS_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `instructor_id` | **Instructor Id** | `INT` | `PRIMARY KEY` | Instructor primary key ID |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to tbl_departments |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | First name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Last name |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Faculty email |

---

---

### Table: `tbl_students`
**Description**: Domain table for `tbl_students` in `Education_LMS_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `student_id` | **Student Id** | `INT` | `PRIMARY KEY` | Student primary key ID |
| `student_number` | **Student Number** | `VARCHAR(20)` | `NOT NULL` | University student ID |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | First name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Last name |
| `gpa` | **Gpa** | `DECIMAL(3,2)` | `NOT NULL` | Cumulative GPA |

---

---

### Table: `tbl_submissions`
**Description**: Domain table for `tbl_submissions` in `Education_LMS_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `submission_id` | **Submission Id** | `INT` | `PRIMARY KEY` | Submission primary key ID |
| `assignment_id` | **Assignment Id** | `INT` | `FOREIGN KEY` | FK to tbl_assignments |
| `student_id` | **Student Id** | `INT` | `FOREIGN KEY` | FK to tbl_students |
| `score_earned` | **Score Earned** | `INT` | `NOT NULL` | Grade points earned |
| `submitted_at` | **Submitted At** | `TIMESTAMP` | `NOT NULL` | Turn in timestamp |

---

---

### Table: `tbl_attorneys_lawyers`
**Description**: Domain table for `tbl_attorneys_lawyers` in `Judicial_Court_Management_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `attorney_id` | **Attorney Id** | `INT` | `PRIMARY KEY` | Attorney primary key ID |
| `license_number` | **License Number** | `VARCHAR(20)` | `NOT NULL` | Legal license bar number |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Attorney first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Attorney last name |
| `firm_name` | **Firm Name** | `VARCHAR(100)` | `NOT NULL` | Law firm or Public Defender office |
| `attorney_type` | **Attorney Type** | `VARCHAR(30)` | `NOT NULL` | PROSECUTOR, DEFENSE, PUBLIC_DEFENDER, CORPORATE |
| `bar_admission_year` | **Bar Admission Year** | `INT` | `NOT NULL` | Year admitted to bar |
| `specialty_area` | **Specialty Area** | `VARCHAR(40)` | `NOT NULL` | Criminal Defense, Corporate, Tax, Family |
| `phone_contact` | **Phone Contact** | `VARCHAR(20)` | `NOT NULL` | Office phone contact |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Professional email address |
| `office_address` | **Office Address** | `VARCHAR(150)` | `NOT NULL` | Law firm office address |
| `billing_hourly_rate_usd` | **Billing Hourly Rate Usd** | `DECIMAL(8,2)` | `NOT NULL` | Billing rate per hour USD |
| `cases_handled_count` | **Cases Handled Count** | `INT` | `NOT NULL` | Total cases represented |
| `win_rate_percentage` | **Win Rate Percentage** | `DECIMAL(5,2)` | `NOT NULL` | Case success rate percentage |
| `disciplinary_actions_count` | **Disciplinary Actions Count** | `INT` | `NOT NULL` | Count of bar complaints/actions |
| `active_status` | **Active Status** | `BOOLEAN` | `NOT NULL` | Active license status |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `district_code` | **District Code** | `VARCHAR(10)` | `NOT NULL` | Primary district code |
| `ratings_score` | **Ratings Score** | `DECIMAL(3,1)` | `NOT NULL` | Peer review rating out of 5.0 |

---

---

### Table: `tbl_case_evidence`
**Description**: Domain table for `tbl_case_evidence` in `Judicial_Court_Management_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `evidence_id` | **Evidence Id** | `INT` | `PRIMARY KEY` | Evidence primary key ID |
| `case_id` | **Case Id** | `INT` | `FOREIGN KEY` | FK to tbl_court_cases |
| `evidence_code` | **Evidence Code** | `VARCHAR(20)` | `NOT NULL` | Barcode or evidence code |
| `evidence_type` | **Evidence Type** | `VARCHAR(40)` | `NOT NULL` | DOCUMENT, DNA, WEAPON, DIGITAL, PHOTO |
| `description` | **Description** | `VARCHAR(200)` | `NOT NULL` | Detailed evidence description |
| `date_collected` | **Date Collected** | `DATE` | `NOT NULL` | Date evidence was seized/collected |
| `collected_by_officer_id` | **Collected By Officer Id** | `INT` | `NOT NULL` | Officer/investigator ID |
| `storage_location` | **Storage Location** | `VARCHAR(50)` | `NOT NULL` | Locker or vault storage unit |
| `chain_of_custody_status` | **Chain Of Custody Status** | `VARCHAR(30)` | `NOT NULL` | VERIFIED, IN_TRANSIT, IN_LAB |
| `is_dna_evidence` | **Is Dna Evidence** | `BOOLEAN` | `NOT NULL` | DNA evidence flag |
| `is_digital_evidence` | **Is Digital Evidence** | `BOOLEAN` | `NOT NULL` | Digital forensic flag |
| `fingerprint_match_status` | **Fingerprint Match Status** | `VARCHAR(20)` | `NOT NULL` | MATCHED, UNMATCHED, INCONCLUSIVE |
| `lab_report_number` | **Lab Report Number** | `VARCHAR(20)` | `NOT NULL` | Crime lab analysis report ID |
| `admissibility_status` | **Admissibility Status** | `VARCHAR(30)` | `NOT NULL` | ADMISSIBLE, SUPPRESSED, CHALLENGED |
| `submitting_party` | **Submitting Party** | `VARCHAR(30)` | `NOT NULL` | PROSECUTION, DEFENSE, COURT |
| `file_attachment_size_mb` | **File Attachment Size Mb** | `DECIMAL(8,2)` | `NOT NULL` | Digital file size in MB |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `evidence_hash` | **Evidence Hash** | `VARCHAR(64)` | `NOT NULL` | SHA-256 digital hash verification |
| `security_level` | **Security Level** | `VARCHAR(15)` | `NOT NULL` | RESTRICTED, CONFIDENTIAL, PUBLIC |

---

---

### Table: `tbl_court_cases`
**Description**: Domain table for `tbl_court_cases` in `Judicial_Court_Management_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `case_id` | **Case Id** | `INT` | `PRIMARY KEY` | Court case primary key ID |
| `case_number` | **Case Number** | `VARCHAR(20)` | `NOT NULL` | Official court case filing number |
| `court_jurisdiction` | **Court Jurisdiction** | `VARCHAR(50)` | `NOT NULL` | District or federal jurisdiction |
| `case_type` | **Case Type** | `VARCHAR(40)` | `NOT NULL` | Civil, Criminal, Family, or Probate |
| `filing_date` | **Filing Date** | `DATE` | `NOT NULL` | Case official filing date |
| `plaintiff_name` | **Plaintiff Name** | `VARCHAR(100)` | `NOT NULL` | Name of plaintiff or prosecutor |
| `defendant_name` | **Defendant Name** | `VARCHAR(100)` | `NOT NULL` | Name of defendant entity or person |
| `presiding_judge_id` | **Presiding Judge Id** | `INT` | `FOREIGN KEY` | FK to tbl_judges_magistrates |
| `assigned_attorney_id` | **Assigned Attorney Id** | `INT` | `FOREIGN KEY` | FK to tbl_attorneys_lawyers |
| `courtroom_number` | **Courtroom Number** | `VARCHAR(10)` | `NOT NULL` | Assigned courtroom number |
| `case_status` | **Case Status** | `VARCHAR(30)` | `NOT NULL` | PENDING, IN_TRIAL, DISPOSED, APPEALED |
| `bail_amount_usd` | **Bail Amount Usd** | `DECIMAL(10,2)` | `NOT NULL` | Bail or bond amount set USD |
| `verdict_status` | **Verdict Status** | `VARCHAR(30)` | `NOT NULL` | GUILTY, NOT_GUILTY, SETTLED, NONE |
| `hearing_count` | **Hearing Count** | `INT` | `NOT NULL` | Total number of hearings held |
| `statute_code` | **Statute Code** | `VARCHAR(20)` | `NOT NULL` | Legal statute or penal code reference |
| `claim_amount_usd` | **Claim Amount Usd** | `DECIMAL(12,2)` | `NOT NULL` | Financial damages or claim amount |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Record last update timestamp |
| `district_code` | **District Code** | `VARCHAR(10)` | `NOT NULL` | Judicial district code |
| `is_appealed` | **Is Appealed** | `BOOLEAN` | `NOT NULL` | Whether case was appealed |
| `priority_level` | **Priority Level** | `VARCHAR(15)` | `NOT NULL` | HIGH, MEDIUM, LOW, URGENT |
| `case_summary_notes` | **Case Summary Notes** | `VARCHAR(255)` | `NOT NULL` | Summary notes of court proceedings |

---

---

### Table: `tbl_court_hearings`
**Description**: Domain table for `tbl_court_hearings` in `Judicial_Court_Management_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `hearing_id` | **Hearing Id** | `INT` | `PRIMARY KEY` | Hearing primary key ID |
| `case_id` | **Case Id** | `INT` | `FOREIGN KEY` | FK to tbl_court_cases |
| `hearing_number` | **Hearing Number** | `INT` | `NOT NULL` | Sequential hearing number for case |
| `scheduled_date` | **Scheduled Date** | `DATE` | `NOT NULL` | Scheduled hearing date |
| `actual_start_time` | **Actual Start Time** | `TIMESTAMP` | `NOT NULL` | Hearing start timestamp |
| `actual_end_time` | **Actual End Time** | `TIMESTAMP` | `NOT NULL` | Hearing end timestamp |
| `judge_id` | **Judge Id** | `INT` | `FOREIGN KEY` | FK to tbl_judges_magistrates |
| `hearing_type` | **Hearing Type** | `VARCHAR(40)` | `NOT NULL` | ARRAIGNMENT, MOTION, TRIAL, SENTENCING |
| `courtroom_code` | **Courtroom Code** | `VARCHAR(10)` | `NOT NULL` | Courtroom identifier |
| `hearing_outcome` | **Hearing Outcome** | `VARCHAR(50)` | `NOT NULL` | Outcome or order issued |
| `is_public_proceeding` | **Is Public Proceeding** | `BOOLEAN` | `NOT NULL` | Whether public attendance is allowed |
| `stenographer_name` | **Stenographer Name** | `VARCHAR(100)` | `NOT NULL` | Official court reporter name |
| `transcript_page_count` | **Transcript Page Count** | `INT` | `NOT NULL` | Number of transcript pages |
| `next_hearing_date` | **Next Hearing Date** | `DATE` | `NOT NULL` | Next scheduled hearing date |
| `bail_decision` | **Bail Decision** | `VARCHAR(30)` | `NOT NULL` | MAINTAINED, INCREASED, REVOKED, GRANTED |
| `contempt_citation_count` | **Contempt Citation Count** | `INT` | `NOT NULL` | Count of contempt citations issued |
| `evidence_presented_count` | **Evidence Presented Count** | `INT` | `NOT NULL` | Number of evidence items presented |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `hearing_status` | **Hearing Status** | `VARCHAR(20)` | `NOT NULL` | COMPLETED, ADJOURNED, CANCELLED |

---

---

### Table: `tbl_judges_magistrates`
**Description**: Domain table for `tbl_judges_magistrates` in `Judicial_Court_Management_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `judge_id` | **Judge Id** | `INT` | `PRIMARY KEY` | Judge primary key ID |
| `judge_code` | **Judge Code** | `VARCHAR(15)` | `NOT NULL` | Official judicial badge/code |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Judge first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Judge last name |
| `appointment_date` | **Appointment Date** | `DATE` | `NOT NULL` | Date of judicial appointment |
| `jurisdiction_district` | **Jurisdiction District** | `VARCHAR(50)` | `NOT NULL` | District jurisdiction area |
| `court_level` | **Court Level** | `VARCHAR(30)` | `NOT NULL` | MAGISTRATE, DISTRICT, APPELLATE, SUPREME |
| `specialization` | **Specialization** | `VARCHAR(40)` | `NOT NULL` | CRIMINAL, CIVIL, CONSTITUTIONAL, COMMERCIAL |
| `bar_association_number` | **Bar Association Number** | `VARCHAR(20)` | `NOT NULL` | State Bar license number |
| `total_cases_tried` | **Total Cases Tried** | `INT` | `NOT NULL` | Lifetime total cases tried |
| `active_status` | **Active Status** | `BOOLEAN` | `NOT NULL` | Active judicial status |
| `salary_amount_usd` | **Salary Amount Usd** | `DECIMAL(10,2)` | `NOT NULL` | Annual judicial salary USD |
| `office_room_number` | **Office Room Number** | `VARCHAR(10)` | `NOT NULL` | Chambers room number |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Judicial email contact |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NOT NULL` | Chambers direct phone |
| `years_of_experience` | **Years Of Experience** | `INT` | `NOT NULL` | Years on the bench |
| `education_degree` | **Education Degree** | `VARCHAR(50)` | `NOT NULL` | Juris Doctor / Master of Laws |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `notes` | **Notes** | `VARCHAR(200)` | `NOT NULL` | Judicial tenure notes |

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

### Table: `tbl_customers`
**Description**: Domain table for `tbl_customers` in `Ecommerce_Dataset` (source).

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

### Table: `tbl_customers_finance_finance`
**Description**: Domain table for `tbl_customers_finance` in `Finance_Banking_Dataset` (source).

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