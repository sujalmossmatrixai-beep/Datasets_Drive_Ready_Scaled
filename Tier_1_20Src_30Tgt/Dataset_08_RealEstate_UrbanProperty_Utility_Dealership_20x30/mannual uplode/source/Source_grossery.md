# Business Data Glossary - Dataset_08_RealEstate_UrbanProperty_Utility_Dealership_20x30_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_08_RealEstate_UrbanProperty_Utility_Dealership_20x30_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_08_RealEstate_UrbanProperty_Utility_Dealership_20x30
- **Component**: Source Database Schema (Dataset_08_RealEstate_UrbanProperty_Utility_Dealership_20x30_source)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Source Tables**: 20
- **Theme Focus**: Commercial Real Estate, Automotive Dealerships, Smart Utilities & Hospitality Assets
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `tbl_agents`
**Description**: Domain table for `tbl_agents` in `Real_Estate_Property_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `agent_id` | **Agent Id** | `INT` | `PRIMARY KEY` | Agent primary key ID |
| `license_number` | **License Number** | `VARCHAR(30)` | `NOT NULL` | Realtor license number |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Given name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Family name |
| `agency_name` | **Agency Name** | `VARCHAR(80)` | `NOT NULL` | Brokerage firm |

---

---

### Table: `tbl_leases`
**Description**: Domain table for `tbl_leases` in `Real_Estate_Property_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lease_id` | **Lease Id** | `INT` | `PRIMARY KEY` | Lease primary key ID |
| `property_id` | **Property Id** | `INT` | `FOREIGN KEY` | FK to tbl_properties |
| `tenant_id` | **Tenant Id** | `INT` | `FOREIGN KEY` | FK to tbl_tenant_master |
| `monthly_rent` | **Monthly Rent** | `DECIMAL(10,2)` | `NOT NULL` | Monthly lease rent |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Lease start date |
| `end_date` | **End Date** | `DATE` | `NOT NULL` | Lease expiration date |

---

---

### Table: `tbl_listings`
**Description**: Domain table for `tbl_listings` in `Real_Estate_Property_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `listing_id` | **Listing Id** | `INT` | `PRIMARY KEY` | Listing primary key ID |
| `property_id` | **Property Id** | `INT` | `FOREIGN KEY` | FK to tbl_properties |
| `agent_id` | **Agent Id** | `INT` | `FOREIGN KEY` | FK to tbl_agents |
| `listing_price` | **Listing Price** | `DECIMAL(12,2)` | `NOT NULL` | Asking price |
| `listing_status` | **Listing Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE/PENDING/SOLD/RENTED |

---

---

### Table: `tbl_properties`
**Description**: Domain table for `tbl_properties` in `Real_Estate_Property_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `property_id` | **Property Id** | `INT` | `PRIMARY KEY` | Property primary key ID |
| `owner_id` | **Owner Id** | `INT` | `FOREIGN KEY` | FK to tbl_property_owners |
| `property_type` | **Property Type** | `VARCHAR(30)` | `NOT NULL` | SINGLE_FAMILY/CONDO/COMMERCIAL |
| `street_address` | **Street Address** | `VARCHAR(100)` | `NOT NULL` | Address line |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State code |
| `square_feet` | **Square Feet** | `INT` | `NOT NULL` | Living area sqft |

---

---

### Table: `tbl_property_images`
**Description**: Domain table for `tbl_property_images` in `Real_Estate_Property_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `image_id` | **Image Id** | `INT` | `PRIMARY KEY` | Image primary key ID |
| `property_id` | **Property Id** | `INT` | `FOREIGN KEY` | FK to tbl_properties |
| `image_url` | **Image Url** | `VARCHAR(255)` | `NOT NULL` | Cloud storage URL |
| `is_primary` | **Is Primary** | `VARCHAR(1)` | `NOT NULL` | Primary cover image Y/N |

---

---

### Table: `tbl_property_owners`
**Description**: Domain table for `tbl_property_owners` in `Real_Estate_Property_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `owner_id` | **Owner Id** | `INT` | `PRIMARY KEY` | Owner primary key ID |
| `tax_id` | **Tax Id** | `VARCHAR(20)` | `NOT NULL` | SSN or Tax EIN |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Owner full name |
| `contact_phone` | **Contact Phone** | `VARCHAR(20)` | `NOT NULL` | Contact phone |

---

---

### Table: `tbl_rent_payments`
**Description**: Domain table for `tbl_rent_payments` in `Real_Estate_Property_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payment_id` | **Payment Id** | `INT` | `PRIMARY KEY` | Payment primary key ID |
| `lease_id` | **Lease Id** | `INT` | `FOREIGN KEY` | FK to tbl_leases |
| `payment_amount` | **Payment Amount** | `DECIMAL(10,2)` | `NOT NULL` | Paid rent amount |
| `payment_date` | **Payment Date** | `DATE` | `NOT NULL` | Payment date |

---

---

### Table: `tbl_tenant_master`
**Description**: Domain table for `tbl_tenant_master` in `Real_Estate_Property_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tenant_id` | **Tenant Id** | `INT` | `PRIMARY KEY` | Tenant primary key ID |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | First name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Last name |
| `credit_score` | **Credit Score** | `INT` | `NOT NULL` | FICO credit score |

---

---

### Table: `tbl_car_buyers`
**Description**: Domain table for `tbl_car_buyers` in `Automotive_Dealership_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `buyer_id` | **Buyer Id** | `INT` | `PRIMARY KEY` | Buyer primary key ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full buyer name |
| `phone` | **Phone** | `VARCHAR(20)` | `NOT NULL` | Contact phone |

---

---

### Table: `tbl_dealership_branches`
**Description**: Domain table for `tbl_dealership_branches` in `Automotive_Dealership_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dealership_id` | **Dealership Id** | `INT` | `PRIMARY KEY` | Dealership primary key ID |
| `dealer_code` | **Dealer Code** | `VARCHAR(15)` | `NOT NULL` | Dealer franchise code |
| `dealer_name` | **Dealer Name** | `VARCHAR(80)` | `NOT NULL` | Dealership name |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City |

---

---

### Table: `tbl_parts_inventory`
**Description**: Domain table for `tbl_parts_inventory` in `Automotive_Dealership_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `part_id` | **Part Id** | `INT` | `PRIMARY KEY` | Part primary key ID |
| `part_number` | **Part Number** | `VARCHAR(30)` | `NOT NULL` | OEM Part number |
| `part_name` | **Part Name** | `VARCHAR(80)` | `NOT NULL` | Part title |
| `unit_cost` | **Unit Cost** | `DECIMAL(8,2)` | `NOT NULL` | Cost per unit |

---

---

### Table: `tbl_sales_representatives`
**Description**: Domain table for `tbl_sales_representatives` in `Automotive_Dealership_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `salesrep_id` | **Salesrep Id** | `INT` | `PRIMARY KEY` | Salesrep primary key ID |
| `dealership_id` | **Dealership Id** | `INT` | `FOREIGN KEY` | FK to tbl_dealership_branches |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | First name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Last name |

---

---

### Table: `tbl_service_appointments`
**Description**: Domain table for `tbl_service_appointments` in `Automotive_Dealership_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `service_id` | **Service Id** | `INT` | `PRIMARY KEY` | Service primary key ID |
| `vehicle_id` | **Vehicle Id** | `INT` | `FOREIGN KEY` | FK to tbl_vehicle_inventory |
| `service_type` | **Service Type** | `VARCHAR(50)` | `NOT NULL` | OIL_CHANGE/BRAKES/REPAIR |
| `service_cost` | **Service Cost** | `DECIMAL(8,2)` | `NOT NULL` | Total repair charge |

---

---

### Table: `tbl_vehicle_inventory`
**Description**: Domain table for `tbl_vehicle_inventory` in `Automotive_Dealership_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vehicle_id` | **Vehicle Id** | `INT` | `PRIMARY KEY` | Vehicle primary key ID |
| `dealership_id` | **Dealership Id** | `INT` | `FOREIGN KEY` | FK to tbl_dealership_branches |
| `vin` | **Vin** | `VARCHAR(17)` | `NOT NULL` | Vehicle Identification Number |
| `make` | **Make** | `VARCHAR(30)` | `NOT NULL` | Manufacturer make (Ford/Toyota) |
| `model` | **Model** | `VARCHAR(40)` | `NOT NULL` | Model designation |
| `year` | **Year** | `INT` | `NOT NULL` | Model year |
| `sticker_price` | **Sticker Price** | `DECIMAL(10,2)` | `NOT NULL` | MSRP price |

---

---

### Table: `tbl_vehicle_sales`
**Description**: Domain table for `tbl_vehicle_sales` in `Automotive_Dealership_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `sale_id` | **Sale Id** | `INT` | `PRIMARY KEY` | Sale primary key ID |
| `vehicle_id` | **Vehicle Id** | `INT` | `FOREIGN KEY` | FK to tbl_vehicle_inventory |
| `buyer_id` | **Buyer Id** | `INT` | `FOREIGN KEY` | FK to tbl_car_buyers |
| `salesrep_id` | **Salesrep Id** | `INT` | `FOREIGN KEY` | FK to tbl_sales_representatives |
| `sale_price` | **Sale Price** | `DECIMAL(10,2)` | `NOT NULL` | Final sale price |
| `sale_date` | **Sale Date** | `DATE` | `NOT NULL` | Date of transaction |

---

---

### Table: `tbl_meter_telemetry_reads`
**Description**: Domain table for `tbl_meter_telemetry_reads` in `Energy_Smart_Grid_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `read_id` | **Read Id** | `INT` | `PRIMARY KEY` | Read primary key ID |
| `meter_id` | **Meter Id** | `INT` | `FOREIGN KEY` | FK to tbl_smart_meters |
| `kwh_consumption` | **Kwh Consumption** | `DECIMAL(10,3)` | `NOT NULL` | Power consumption kWh |
| `voltage_reading` | **Voltage Reading** | `DECIMAL(6,2)` | `NOT NULL` | Voltage reading |
| `read_timestamp` | **Read Timestamp** | `TIMESTAMP` | `NOT NULL` | Meter read timestamp |

---

---

### Table: `tbl_power_outage_events`
**Description**: Domain table for `tbl_power_outage_events` in `Energy_Smart_Grid_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `outage_id` | **Outage Id** | `INT` | `PRIMARY KEY` | Outage primary key ID |
| `substation_id` | **Substation Id** | `INT` | `FOREIGN KEY` | FK to tbl_substations |
| `affected_customers` | **Affected Customers** | `INT` | `NOT NULL` | Impacted customer count |
| `outage_start` | **Outage Start** | `TIMESTAMP` | `NOT NULL` | Outage start |

---

---

### Table: `tbl_smart_meters`
**Description**: Domain table for `tbl_smart_meters` in `Energy_Smart_Grid_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `meter_id` | **Meter Id** | `INT` | `PRIMARY KEY` | Meter primary key ID |
| `substation_id` | **Substation Id** | `INT` | `FOREIGN KEY` | FK to tbl_substations |
| `meter_serial_number` | **Meter Serial Number** | `VARCHAR(30)` | `NOT NULL` | Hardware serial number |

---

---

### Table: `tbl_substations`
**Description**: Domain table for `tbl_substations` in `Energy_Smart_Grid_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `substation_id` | **Substation Id** | `INT` | `PRIMARY KEY` | Substation primary key ID |
| `grid_code` | **Grid Code** | `VARCHAR(20)` | `NOT NULL` | Grid station code |
| `region_name` | **Region Name** | `VARCHAR(50)` | `NOT NULL` | Service region |

---

---

### Table: `tbl_guest_feedback`
**Description**: Domain table for `tbl_guest_feedback` in `Hotel_Hospitality_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `feedback_id` | **Feedback Id** | `INT` | `PRIMARY KEY` | Feedback primary key ID |
| `reservation_id` | **Reservation Id** | `INT` | `FOREIGN KEY` | FK to tbl_reservations |
| `cleanliness_score` | **Cleanliness Score** | `INT` | `NOT NULL` | Score 1-10 |
| `staff_score` | **Staff Score** | `INT` | `NOT NULL` | Score 1-10 |

---