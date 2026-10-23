# Business Data Glossary - Dataset_07_Enterprise_HR_CloudSaaS_Judicial_60x50_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_07_Enterprise_HR_CloudSaaS_Judicial_60x50_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_07_Enterprise_HR_CloudSaaS_Judicial_60x50
- **Component**: Target Database Schema (Dataset_07_Enterprise_HR_CloudSaaS_Judicial_60x50_target)
- **Tier Specification**: Tier 2: 60 Source Tables, 50 Target Tables
- **Total Target Tables**: 50
- **Theme Focus**: Enterprise HR & Payroll, Cloud SaaS Subscriptions, LMS & Judicial Legal Systems
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `dim_department`
**Description**: Domain table for `dim_department` in `HR_Payroll_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `department_key` | **Department Key** | `BIGINT` | `PRIMARY KEY` | Department surrogate key |
| `source_dept_id` | **Source Dept Id** | `INT` | `NOT NULL` | Source department natural ID |
| `department_code` | **Department Code** | `VARCHAR(10)` | `NOT NULL` | Natural department code |
| `department_name` | **Department Name** | `VARCHAR(50)` | `NOT NULL` | Department name |
| `manager_employee_key` | **Manager Employee Key** | `BIGINT` | `NOT NULL` | Managing employee key |
| `location_key` | **Location Key** | `BIGINT` | `NOT NULL` | Office location key |
| `annual_budget_usd` | **Annual Budget Usd** | `NUMERIC(12,2)` | `NOT NULL` | Annual budget USD |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | Active boolean indicator |

---

---

### Table: `dim_employee`
**Description**: Domain table for `dim_employee` in `HR_Payroll_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `employee_key` | **Employee Key** | `BIGINT` | `PRIMARY KEY` | Employee surrogate key |
| `source_employee_id` | **Source Employee Id** | `INT` | `NOT NULL` | Source natural employee ID |
| `national_id` | **National Id** | `VARCHAR(11)` | `NOT NULL` | Masked national identity SSN |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full employee name |
| `work_email` | **Work Email** | `VARCHAR(100)` | `NOT NULL` | Corporate email address |
| `hire_date` | **Hire Date** | `DATE` | `NOT NULL` | Employment start date |
| `job_title` | **Job Title** | `VARCHAR(50)` | `NOT NULL` | Standardized job title |
| `department_key` | **Department Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_department |
| `employment_status_code` | **Employment Status Code** | `VARCHAR(15)` | `NOT NULL` | Employment status code |

---

---

### Table: `dim_job_positions`
**Description**: Domain table for `dim_job_positions` in `HR_Payroll_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `position_key` | **Position Key** | `BIGINT` | `PRIMARY KEY` | Position surrogate key |
| `position_code` | **Position Code** | `VARCHAR(10)` | `NOT NULL` | Natural position code |
| `position_title` | **Position Title** | `VARCHAR(50)` | `NOT NULL` | Position title name |
| `salary_grade_min` | **Salary Grade Min** | `NUMERIC(10,2)` | `NOT NULL` | Minimum salary USD |
| `salary_grade_max` | **Salary Grade Max** | `NUMERIC(10,2)` | `NOT NULL` | Maximum salary USD |
| `department_key` | **Department Key** | `BIGINT` | `NOT NULL` | FK to dim_department |
| `position_status` | **Position Status** | `VARCHAR(10)` | `NOT NULL` | Position status |

---

---

### Table: `fact_daily_attendance`
**Description**: Domain table for `fact_daily_attendance` in `HR_Payroll_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `attendance_key` | **Attendance Key** | `BIGINT` | `PRIMARY KEY` | Attendance surrogate key |
| `employee_key` | **Employee Key** | `BIGINT` | `NOT NULL` | FK to dim_employee |
| `shift_date` | **Shift Date** | `DATE` | `NOT NULL` | Work shift date |
| `clock_in_timestamp` | **Clock In Timestamp** | `TIMESTAMP` | `NOT NULL` | Clock in ISO timestamp |
| `clock_out_timestamp` | **Clock Out Timestamp** | `TIMESTAMP` | `NOT NULL` | Clock out ISO timestamp |
| `total_worked_hours` | **Total Worked Hours** | `NUMERIC(4,2)` | `NOT NULL` | Total regular worked hours |
| `total_overtime_hours` | **Total Overtime Hours** | `NUMERIC(4,2)` | `NOT NULL` | Total overtime worked hours |
| `attendance_status` | **Attendance Status** | `VARCHAR(15)` | `NOT NULL` | Attendance status code |

---

---

### Table: `fact_employee_benefits`
**Description**: Domain table for `fact_employee_benefits` in `HR_Payroll_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `benefit_key` | **Benefit Key** | `BIGINT` | `PRIMARY KEY` | Benefit surrogate key |
| `employee_key` | **Employee Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_employee |
| `benefit_plan_name` | **Benefit Plan Name** | `VARCHAR(50)` | `NOT NULL` | Benefit plan title |
| `benefit_category` | **Benefit Category** | `VARCHAR(25)` | `NOT NULL` | Benefit category code |
| `employer_contribution_usd` | **Employer Contribution Usd** | `NUMERIC(8,2)` | `NOT NULL` | Monthly employer cost USD |
| `employee_contribution_usd` | **Employee Contribution Usd** | `NUMERIC(8,2)` | `NOT NULL` | Monthly employee cost USD |
| `enrollment_date` | **Enrollment Date** | `DATE` | `NOT NULL` | Plan enrollment date |
| `coverage_status` | **Coverage Status** | `VARCHAR(15)` | `NOT NULL` | Coverage status |

---

---

### Table: `fact_payroll_disbursements`
**Description**: Domain table for `fact_payroll_disbursements` in `HR_Payroll_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payroll_key` | **Payroll Key** | `BIGINT` | `PRIMARY KEY` | Payroll surrogate key |
| `employee_key` | **Employee Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_employee |
| `pay_period_start_date` | **Pay Period Start Date** | `DATE` | `NOT NULL` | Pay period start date |
| `pay_period_end_date` | **Pay Period End Date** | `DATE` | `NOT NULL` | Pay period end date |
| `gross_pay_usd` | **Gross Pay Usd** | `NUMERIC(10,2)` | `NOT NULL` | Gross compensation pay USD |
| `net_pay_usd` | **Net Pay Usd** | `NUMERIC(10,2)` | `NOT NULL` | Net take-home pay USD |
| `total_tax_deduction_usd` | **Total Tax Deduction Usd** | `NUMERIC(10,2)` | `NOT NULL` | Total tax withholdings USD |
| `disbursement_date` | **Disbursement Date** | `DATE` | `NOT NULL` | Disbursement execution date |
| `payment_status` | **Payment Status** | `VARCHAR(15)` | `NOT NULL` | Payment status code |

---

---

### Table: `fact_performance_appraisals`
**Description**: Domain table for `fact_performance_appraisals` in `HR_Payroll_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `review_key` | **Review Key** | `BIGINT` | `PRIMARY KEY` | Performance review surrogate key |
| `employee_key` | **Employee Key** | `BIGINT` | `NOT NULL` | FK to dim_employee |
| `reviewer_employee_key` | **Reviewer Employee Key** | `BIGINT` | `NOT NULL` | Reviewer employee key |
| `appraisal_cycle` | **Appraisal Cycle** | `VARCHAR(10)` | `NOT NULL` | Appraisal cycle period |
| `rating_score` | **Rating Score** | `NUMERIC(3,2)` | `NOT NULL` | Score decimal 1.00 - 5.00 |
| `appraisal_date` | **Appraisal Date** | `DATE` | `NOT NULL` | Review date |
| `evaluation_notes` | **Evaluation Notes** | `TEXT` | `NULL` | Appraisal summary comments |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Review status |

---

---

### Table: `fact_salary_history`
**Description**: Domain table for `fact_salary_history` in `HR_Payroll_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `salary_key` | **Salary Key** | `BIGINT` | `PRIMARY KEY` | Salary surrogate key |
| `employee_key` | **Employee Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_employee |
| `base_salary_usd` | **Base Salary Usd** | `NUMERIC(10,2)` | `NOT NULL` | Annual base salary USD |
| `currency_code` | **Currency Code** | `VARCHAR(3)` | `NOT NULL` | ISO currency code |
| `effective_date` | **Effective Date** | `DATE` | `NOT NULL` | Start effective date |
| `end_date` | **End Date** | `DATE` | `NULL` | End effective date |
| `pay_frequency_code` | **Pay Frequency Code** | `VARCHAR(15)` | `NOT NULL` | Pay frequency code |
| `is_active_record` | **Is Active Record** | `BOOLEAN` | `NOT NULL` | Current active salary record flag |

---

---

### Table: `fact_timeoff`
**Description**: Domain table for `fact_timeoff` in `HR_Payroll_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `timeoff_key` | **Timeoff Key** | `BIGINT` | `PRIMARY KEY` | Timeoff surrogate key |
| `employee_key` | **Employee Key** | `BIGINT` | `NOT NULL` | FK to dim_employee |
| `leave_category` | **Leave Category** | `VARCHAR(20)` | `NOT NULL` | Leave category code |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Leave start date |
| `end_date` | **End Date** | `DATE` | `NOT NULL` | Leave end date |
| `duration_days` | **Duration Days** | `NUMERIC(4,1)` | `NOT NULL` | Duration in work days |
| `approval_status_code` | **Approval Status Code** | `VARCHAR(15)` | `NOT NULL` | Approval status code |
| `request_timestamp` | **Request Timestamp** | `TIMESTAMP` | `NOT NULL` | Request timestamp ISO |

---

---

### Table: `fact_training_completions`
**Description**: Domain table for `fact_training_completions` in `HR_Payroll_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `training_key` | **Training Key** | `BIGINT` | `PRIMARY KEY` | Training completion surrogate key |
| `employee_key` | **Employee Key** | `BIGINT` | `NOT NULL` | FK to dim_employee |
| `course_title` | **Course Title** | `VARCHAR(80)` | `NOT NULL` | Course title name |
| `training_provider` | **Training Provider** | `VARCHAR(50)` | `NOT NULL` | Provider name |
| `completion_date` | **Completion Date** | `DATE` | `NOT NULL` | Completion date |
| `final_score_pct` | **Final Score Pct** | `INT` | `NOT NULL` | Score percentage |
| `certification_flag` | **Certification Flag** | `BOOLEAN` | `NOT NULL` | Certification earned boolean flag |

---

---

### Table: `dim_saas_plan`
**Description**: Domain table for `dim_saas_plan` in `SaaS_Subscription_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `plan_key` | **Plan Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_plan_id` | **Source Plan Id** | `INT` | `NOT NULL` | Natural ID |
| `plan_name` | **Plan Name** | `VARCHAR(40)` | `NOT NULL` | Plan name |

---

---

### Table: `dim_tenant`
**Description**: Domain table for `dim_tenant` in `SaaS_Subscription_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tenant_key` | **Tenant Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_tenant_id` | **Source Tenant Id** | `INT` | `NOT NULL` | Natural ID |
| `company_name` | **Company Name** | `VARCHAR(100)` | `NOT NULL` | Company name |

---

---

### Table: `fact_api_usage`
**Description**: Domain table for `fact_api_usage` in `SaaS_Subscription_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `usage_fact_key` | **Usage Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `tenant_key` | **Tenant Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_tenant |
| `api_calls_count` | **Api Calls Count** | `INT` | `NOT NULL` | Call volume |

---

---

### Table: `fact_mrr_subscriptions`
**Description**: Domain table for `fact_mrr_subscriptions` in `SaaS_Subscription_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `mrr_fact_key` | **Mrr Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `tenant_key` | **Tenant Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_tenant |
| `plan_key` | **Plan Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_saas_plan |
| `mrr_amount_usd` | **Mrr Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Monthly recurring revenue USD |

---

---

### Table: `dim_course`
**Description**: Domain table for `dim_course` in `Education_LMS_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `course_key` | **Course Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_course_id` | **Source Course Id** | `INT` | `NOT NULL` | Natural ID |
| `instructor_key` | **Instructor Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_instructor |
| `course_code` | **Course Code** | `VARCHAR(15)` | `NOT NULL` | Course code |
| `course_title` | **Course Title** | `VARCHAR(100)` | `NOT NULL` | Course title |

---

---

### Table: `dim_instructor`
**Description**: Domain table for `dim_instructor` in `Education_LMS_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `instructor_key` | **Instructor Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_instructor_id` | **Source Instructor Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `dim_student`
**Description**: Domain table for `dim_student` in `Education_LMS_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `student_key` | **Student Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_student_id` | **Source Student Id** | `INT` | `NOT NULL` | Natural ID |
| `student_number` | **Student Number** | `VARCHAR(20)` | `NOT NULL` | Student ID number |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `fact_assignment_submission`
**Description**: Domain table for `fact_assignment_submission` in `Education_LMS_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `submission_key` | **Submission Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `course_key` | **Course Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_course |
| `student_key` | **Student Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_student |
| `score_earned` | **Score Earned** | `INT` | `NOT NULL` | Points earned |

---

---

### Table: `fact_enrollment`
**Description**: Domain table for `fact_enrollment` in `Education_LMS_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `enrollment_key` | **Enrollment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `course_key` | **Course Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_course |
| `student_key` | **Student Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_student |
| `final_grade_code` | **Final Grade Code** | `VARCHAR(2)` | `NULL` | Grade letter |

---

---

### Table: `dim_attorney`
**Description**: Domain table for `dim_attorney` in `Judicial_Court_Management_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `attorney_key` | **Attorney Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for attorney dimension |
| `source_attorney_id` | **Source Attorney Id** | `INT` | `NOT NULL` | Natural attorney ID from source |
| `license_number` | **License Number** | `VARCHAR(20)` | `NOT NULL` | License bar number |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Attorney full name |
| `law_firm_name` | **Law Firm Name** | `VARCHAR(100)` | `NOT NULL` | Firm or office name |
| `attorney_type` | **Attorney Type** | `VARCHAR(30)` | `NOT NULL` | Attorney classification |
| `specialty_area` | **Specialty Area** | `VARCHAR(40)` | `NOT NULL` | Legal specialty |
| `bar_admission_year` | **Bar Admission Year** | `INT` | `NOT NULL` | Bar admission year |
| `billing_hourly_rate_usd` | **Billing Hourly Rate Usd** | `NUMERIC(8,2)` | `NOT NULL` | Hourly billing rate USD |
| `win_rate_percentage` | **Win Rate Percentage** | `NUMERIC(5,2)` | `NOT NULL` | Win rate % |
| `cases_handled_count` | **Cases Handled Count** | `INT` | `NOT NULL` | Cases count |
| `office_address` | **Office Address** | `VARCHAR(150)` | `NOT NULL` | Office street address |
| `district_code` | **District Code** | `VARCHAR(10)` | `NOT NULL` | District code |
| `peer_rating_score` | **Peer Rating Score** | `NUMERIC(3,1)` | `NOT NULL` | Peer score out of 5 |
| `active_flag` | **Active Flag** | `BOOLEAN` | `NOT NULL` | Active flag |
| `email_contact` | **Email Contact** | `VARCHAR(100)` | `NOT NULL` | Email contact |
| `phone_contact` | **Phone Contact** | `VARCHAR(20)` | `NOT NULL` | Phone contact |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_court_case`
**Description**: Domain table for `dim_court_case` in `Judicial_Court_Management_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `case_key` | **Case Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for case dimension |
| `source_case_id` | **Source Case Id** | `INT` | `NOT NULL` | Natural case ID from source |
| `case_number` | **Case Number** | `VARCHAR(20)` | `NOT NULL` | Case reference number |
| `jurisdiction_name` | **Jurisdiction Name** | `VARCHAR(50)` | `NOT NULL` | Court jurisdiction name |
| `case_type_category` | **Case Type Category** | `VARCHAR(40)` | `NOT NULL` | Civil, Criminal, Family, Probate |
| `filing_date` | **Filing Date** | `DATE` | `NOT NULL` | Filing date dimension key |
| `plaintiff_full_name` | **Plaintiff Full Name** | `VARCHAR(100)` | `NOT NULL` | Plaintiff full name |
| `defendant_full_name` | **Defendant Full Name** | `VARCHAR(100)` | `NOT NULL` | Defendant full name |
| `courtroom_identifier` | **Courtroom Identifier** | `VARCHAR(10)` | `NOT NULL` | Courtroom identifier |
| `statute_reference` | **Statute Reference** | `VARCHAR(20)` | `NOT NULL` | Statute code reference |
| `district_code` | **District Code** | `VARCHAR(10)` | `NOT NULL` | District code |
| `priority_level` | **Priority Level** | `VARCHAR(15)` | `NOT NULL` | Priority classification |
| `is_appealed_flag` | **Is Appealed Flag** | `BOOLEAN` | `NOT NULL` | Is appealed indicator |
| `claim_amount_usd` | **Claim Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Claim amount USD |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_active_case` | **Is Active Case** | `BOOLEAN` | `NOT NULL` | Active case flag |
| `effective_start_date` | **Effective Start Date** | `DATE` | `NOT NULL` | SCD Type 2 effective start |
| `effective_end_date` | **Effective End Date** | `DATE` | `NOT NULL` | SCD Type 2 effective end |
| `is_current_record` | **Is Current Record** | `BOOLEAN` | `NOT NULL` | SCD Type 2 current flag |
| `summary_notes` | **Summary Notes** | `VARCHAR(255)` | `NOT NULL` | Case summary text |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_judge`
**Description**: Domain table for `dim_judge` in `Judicial_Court_Management_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `judge_key` | **Judge Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for judge dimension |
| `source_judge_id` | **Source Judge Id** | `INT` | `NOT NULL` | Natural judge ID from source |
| `judge_code` | **Judge Code** | `VARCHAR(15)` | `NOT NULL` | Judicial badge code |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Judge full name |
| `court_level` | **Court Level** | `VARCHAR(30)` | `NOT NULL` | Judicial court rank |
| `specialization` | **Specialization** | `VARCHAR(40)` | `NOT NULL` | Specialty domain |
| `jurisdiction_district` | **Jurisdiction District** | `VARCHAR(50)` | `NOT NULL` | District jurisdiction |
| `appointment_date` | **Appointment Date** | `DATE` | `NOT NULL` | Appointment date |
| `bar_number` | **Bar Number** | `VARCHAR(20)` | `NOT NULL` | Bar license number |
| `years_of_experience` | **Years Of Experience** | `INT` | `NOT NULL` | Years of judicial service |
| `education_degree` | **Education Degree** | `VARCHAR(50)` | `NOT NULL` | Degree qualification |
| `salary_amount_usd` | **Salary Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Salary USD |
| `active_status` | **Active Status** | `BOOLEAN` | `NOT NULL` | Active status flag |
| `office_chambers` | **Office Chambers** | `VARCHAR(10)` | `NOT NULL` | Chambers room |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Email contact |
| `phone_contact` | **Phone Contact** | `VARCHAR(20)` | `NOT NULL` | Phone contact |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current` | **Is Current** | `BOOLEAN` | `NOT NULL` | Current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_case_dispositions`
**Description**: Domain table for `fact_case_dispositions` in `Judicial_Court_Management_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `disposition_key` | **Disposition Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for disposition fact |
| `case_key` | **Case Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_court_case |
| `judge_key` | **Judge Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_judge |
| `attorney_key` | **Attorney Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_attorney |
| `disposition_date` | **Disposition Date** | `DATE` | `NOT NULL` | Case disposition date |
| `verdict_type` | **Verdict Type** | `VARCHAR(30)` | `NOT NULL` | GUILTY, NOT_GUILTY, DISMISSED, SETTLED |
| `sentence_months` | **Sentence Months** | `INT` | `NOT NULL` | Incarceration sentence in months |
| `probation_months` | **Probation Months** | `INT` | `NOT NULL` | Probation period in months |
| `fine_amount_usd` | **Fine Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Court fine amount USD |
| `restitution_amount_usd` | **Restitution Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Victim restitution amount USD |
| `court_costs_usd` | **Court Costs Usd** | `NUMERIC(8,2)` | `NOT NULL` | Assessed court fees USD |
| `total_hearings_count` | **Total Hearings Count** | `INT` | `NOT NULL` | Total hearings prior to disposition |
| `case_duration_days` | **Case Duration Days** | `INT` | `NOT NULL` | Days from filing to disposition |
| `is_appealed_flag` | **Is Appealed Flag** | `BOOLEAN` | `NOT NULL` | Appeared flag |
| `district_code` | **District Code** | `VARCHAR(10)` | `NOT NULL` | District code |
| `statute_reference` | **Statute Reference** | `VARCHAR(20)` | `NOT NULL` | Statute reference |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `final_disposition_status` | **Final Disposition Status** | `VARCHAR(20)` | `NOT NULL` | CLOSED, APPEAL_PENDING, EXPUNGED |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_court_hearings`
**Description**: Domain table for `fact_court_hearings` in `Judicial_Court_Management_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `hearing_key` | **Hearing Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for hearing fact |
| `case_key` | **Case Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_court_case |
| `judge_key` | **Judge Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_judge |
| `attorney_key` | **Attorney Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_attorney |
| `hearing_number` | **Hearing Number** | `INT` | `NOT NULL` | Hearing sequence number |
| `hearing_type` | **Hearing Type** | `VARCHAR(40)` | `NOT NULL` | Hearing type text |
| `courtroom_code` | **Courtroom Code** | `VARCHAR(10)` | `NOT NULL` | Courtroom code |
| `scheduled_date` | **Scheduled Date** | `DATE` | `NOT NULL` | Scheduled date |
| `duration_minutes` | **Duration Minutes** | `INT` | `NOT NULL` | Actual duration in minutes |
| `hearing_outcome` | **Hearing Outcome** | `VARCHAR(50)` | `NOT NULL` | Outcome ruling |
| `transcript_pages` | **Transcript Pages** | `INT` | `NOT NULL` | Transcript page count |
| `evidence_count` | **Evidence Count** | `INT` | `NOT NULL` | Evidence items count |
| `contempt_count` | **Contempt Count** | `INT` | `NOT NULL` | Contempt citations count |
| `is_public_flag` | **Is Public Flag** | `BOOLEAN` | `NOT NULL` | Public proceeding flag |
| `bail_amount_usd` | **Bail Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Bail set USD |
| `hearing_status` | **Hearing Status** | `VARCHAR(20)` | `NOT NULL` | Hearing status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `district_code` | **District Code** | `VARCHAR(10)` | `NOT NULL` | District code |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

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

### Table: `dim_customers`
**Description**: Domain table for `dim_customers` in `Ecommerce_Dataset` (target).

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

### Table: `fact_audit_events`
**Description**: Domain table for `fact_audit_events` in `Ecommerce_Dataset` (target).

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

---

### Table: `fhir_audit_event`
**Description**: Domain table for `fhir_audit_event` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `audit_event_key` | **Audit Event Key** | `BIGINT` | `PRIMARY KEY` | Audit event surrogate key |
| `source_log_id` | **Source Log Id** | `INT` | `NOT NULL` | Source natural log ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Clinician user ID |
| `action_code` | **Action Code** | `VARCHAR(30)` | `NOT NULL` | Action performed |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `event_timestamp` | **Event Timestamp** | `TIMESTAMP` | `NOT NULL` | Event ISO timestamp |

---

---

### Table: `fhir_claim`
**Description**: Domain table for `fhir_claim` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `claim_key` | **Claim Key** | `BIGINT` | `PRIMARY KEY` | Claim surrogate key |
| `source_claim_id` | **Source Claim Id** | `INT` | `NOT NULL` | Source natural claim ID |
| `billing_account_key` | **Billing Account Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_account_billing |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `payer_name` | **Payer Name** | `VARCHAR(80)` | `NOT NULL` | Health insurance payer |
| `total_claimed_usd` | **Total Claimed Usd** | `NUMERIC(10,2)` | `NOT NULL` | Claimed total USD |
| `total_covered_usd` | **Total Covered Usd** | `NUMERIC(10,2)` | `NOT NULL` | Approved covered USD |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Claim status |

---

---

### Table: `fhir_condition_diagnosis`
**Description**: Domain table for `fhir_condition_diagnosis` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `condition_key` | **Condition Key** | `BIGINT` | `PRIMARY KEY` | Condition surrogate key |
| `source_diagnosis_id` | **Source Diagnosis Id** | `INT` | `NOT NULL` | Source natural diagnosis ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `icd10_code` | **Icd10 Code** | `VARCHAR(20)` | `NOT NULL` | ICD-10 clinical code |
| `condition_display` | **Condition Display** | `VARCHAR(100)` | `NOT NULL` | Condition display title |
| `onset_date` | **Onset Date** | `DATE` | `NOT NULL` | Condition onset date |

---

---

### Table: `fhir_encounter`
**Description**: Domain table for `fhir_encounter` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `encounter_key` | **Encounter Key** | `BIGINT` | `PRIMARY KEY` | Encounter surrogate key |
| `source_encounter_id` | **Source Encounter Id** | `INT` | `NOT NULL` | Source natural encounter ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `dept_key` | **Dept Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_organization_dept |
| `encounter_class` | **Encounter Class** | `VARCHAR(20)` | `NOT NULL` | Encounter classification |
| `period_start` | **Period Start** | `TIMESTAMP` | `NOT NULL` | Encounter period start |
| `period_end` | **Period End** | `TIMESTAMP` | `NULL` | Encounter period end |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | FHIR status code |

---