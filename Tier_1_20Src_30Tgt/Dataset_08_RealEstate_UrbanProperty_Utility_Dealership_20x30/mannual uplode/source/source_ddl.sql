-- ========================================================
-- Master DDL Schema Script for Dataset_08_RealEstate_UrbanProperty_Utility_Dealership_20x30_source
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 20
-- Domains Included: Dataset_07_Automotive_Dealership_Dataset, Dataset_12_Energy_Smart_Grid_Dataset, Dataset_19_Hotel_Hospitality_Dataset, Dataset_23_Real_Estate_Property_Dataset
-- ========================================================

CREATE TABLE tbl_agents (
    agent_id                       INT             PRIMARY KEY                                                , -- Agent primary key ID
    license_number                 VARCHAR(30)     NOT NULL                                                   , -- Realtor license number
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- Given name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Family name
    agency_name                    VARCHAR(80)     NOT NULL                                                     -- Brokerage firm
);

CREATE TABLE tbl_leases (
    lease_id                       INT             PRIMARY KEY                                                , -- Lease primary key ID
    property_id                    INT             NOT NULL REFERENCES tbl_properties(property_id)            , -- FK to tbl_properties
    tenant_id                      INT             NOT NULL REFERENCES tbl_tenant_master(tenant_id)           , -- FK to tbl_tenant_master
    monthly_rent                   DECIMAL(10,2)   NOT NULL                                                   , -- Monthly lease rent
    start_date                     DATE            NOT NULL                                                   , -- Lease start date
    end_date                       DATE            NOT NULL                                                     -- Lease expiration date
);

CREATE TABLE tbl_listings (
    listing_id                     INT             PRIMARY KEY                                                , -- Listing primary key ID
    property_id                    INT             NOT NULL REFERENCES tbl_properties(property_id)            , -- FK to tbl_properties
    agent_id                       INT             NOT NULL REFERENCES tbl_agents(agent_id)                   , -- FK to tbl_agents
    listing_price                  DECIMAL(12,2)   NOT NULL                                                   , -- Asking price
    listing_status                 VARCHAR(20)     NOT NULL                                                     -- ACTIVE/PENDING/SOLD/RENTED
);

CREATE TABLE tbl_properties (
    property_id                    INT             PRIMARY KEY                                                , -- Property primary key ID
    owner_id                       INT             NOT NULL REFERENCES tbl_property_owners(owner_id)          , -- FK to tbl_property_owners
    property_type                  VARCHAR(30)     NOT NULL                                                   , -- SINGLE_FAMILY/CONDO/COMMERCIAL
    street_address                 VARCHAR(100)    NOT NULL                                                   , -- Address line
    city                           VARCHAR(50)     NOT NULL                                                   , -- City
    state_code                     VARCHAR(5)      NOT NULL                                                   , -- State code
    square_feet                    INT             NOT NULL                                                     -- Living area sqft
);

CREATE TABLE tbl_property_images (
    image_id                       INT             PRIMARY KEY                                                , -- Image primary key ID
    property_id                    INT             NOT NULL REFERENCES tbl_properties(property_id)            , -- FK to tbl_properties
    image_url                      VARCHAR(255)    NOT NULL                                                   , -- Cloud storage URL
    is_primary                     VARCHAR(1)      NOT NULL                                                     -- Primary cover image Y/N
);

CREATE TABLE tbl_property_owners (
    owner_id                       INT             PRIMARY KEY                                                , -- Owner primary key ID
    tax_id                         VARCHAR(20)     NOT NULL                                                   , -- SSN or Tax EIN
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Owner full name
    contact_phone                  VARCHAR(20)     NOT NULL                                                     -- Contact phone
);

CREATE TABLE tbl_rent_payments (
    payment_id                     INT             PRIMARY KEY                                                , -- Payment primary key ID
    lease_id                       INT             NOT NULL REFERENCES tbl_leases(lease_id)                   , -- FK to tbl_leases
    payment_amount                 DECIMAL(10,2)   NOT NULL                                                   , -- Paid rent amount
    payment_date                   DATE            NOT NULL                                                     -- Payment date
);

CREATE TABLE tbl_tenant_master (
    tenant_id                      INT             PRIMARY KEY                                                , -- Tenant primary key ID
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- First name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Last name
    credit_score                   INT             NOT NULL                                                     -- FICO credit score
);

CREATE TABLE tbl_car_buyers (
    buyer_id                       INT             PRIMARY KEY                                                , -- Buyer primary key ID
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Full buyer name
    phone                          VARCHAR(20)     NOT NULL                                                     -- Contact phone
);

CREATE TABLE tbl_dealership_branches (
    dealership_id                  INT             PRIMARY KEY                                                , -- Dealership primary key ID
    dealer_code                    VARCHAR(15)     NOT NULL                                                   , -- Dealer franchise code
    dealer_name                    VARCHAR(80)     NOT NULL                                                   , -- Dealership name
    city                           VARCHAR(50)     NOT NULL                                                     -- City
);

CREATE TABLE tbl_parts_inventory (
    part_id                        INT             PRIMARY KEY                                                , -- Part primary key ID
    part_number                    VARCHAR(30)     NOT NULL                                                   , -- OEM Part number
    part_name                      VARCHAR(80)     NOT NULL                                                   , -- Part title
    unit_cost                      DECIMAL(8,2)    NOT NULL                                                     -- Cost per unit
);

CREATE TABLE tbl_sales_representatives (
    salesrep_id                    INT             PRIMARY KEY                                                , -- Salesrep primary key ID
    dealership_id                  INT             NOT NULL REFERENCES tbl_dealership_branches(dealership_id) , -- FK to tbl_dealership_branches
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- First name
    last_name                      VARCHAR(50)     NOT NULL                                                     -- Last name
);

CREATE TABLE tbl_service_appointments (
    service_id                     INT             PRIMARY KEY                                                , -- Service primary key ID
    vehicle_id                     INT             NOT NULL REFERENCES tbl_vehicle_inventory(vehicle_id)      , -- FK to tbl_vehicle_inventory
    service_type                   VARCHAR(50)     NOT NULL                                                   , -- OIL_CHANGE/BRAKES/REPAIR
    service_cost                   DECIMAL(8,2)    NOT NULL                                                     -- Total repair charge
);

CREATE TABLE tbl_vehicle_inventory (
    vehicle_id                     INT             PRIMARY KEY                                                , -- Vehicle primary key ID
    dealership_id                  INT             NOT NULL REFERENCES tbl_dealership_branches(dealership_id) , -- FK to tbl_dealership_branches
    vin                            VARCHAR(17)     NOT NULL                                                   , -- Vehicle Identification Number
    make                           VARCHAR(30)     NOT NULL                                                   , -- Manufacturer make (Ford/Toyota)
    model                          VARCHAR(40)     NOT NULL                                                   , -- Model designation
    year                           INT             NOT NULL                                                   , -- Model year
    sticker_price                  DECIMAL(10,2)   NOT NULL                                                     -- MSRP price
);

CREATE TABLE tbl_vehicle_sales (
    sale_id                        INT             PRIMARY KEY                                                , -- Sale primary key ID
    vehicle_id                     INT             NOT NULL REFERENCES tbl_vehicle_inventory(vehicle_id)      , -- FK to tbl_vehicle_inventory
    buyer_id                       INT             NOT NULL REFERENCES tbl_car_buyers(buyer_id)               , -- FK to tbl_car_buyers
    salesrep_id                    INT             NOT NULL REFERENCES tbl_sales_representatives(salesrep_id) , -- FK to tbl_sales_representatives
    sale_price                     DECIMAL(10,2)   NOT NULL                                                   , -- Final sale price
    sale_date                      DATE            NOT NULL                                                     -- Date of transaction
);

CREATE TABLE tbl_meter_telemetry_reads (
    read_id                        INT             PRIMARY KEY                                                , -- Read primary key ID
    meter_id                       INT             NOT NULL REFERENCES tbl_smart_meters(meter_id)             , -- FK to tbl_smart_meters
    kwh_consumption                DECIMAL(10,3)   NOT NULL                                                   , -- Power consumption kWh
    voltage_reading                DECIMAL(6,2)    NOT NULL                                                   , -- Voltage reading
    read_timestamp                 TIMESTAMP       NOT NULL                                                     -- Meter read timestamp
);

CREATE TABLE tbl_power_outage_events (
    outage_id                      INT             PRIMARY KEY                                                , -- Outage primary key ID
    substation_id                  INT             NOT NULL REFERENCES tbl_substations(substation_id)         , -- FK to tbl_substations
    affected_customers             INT             NOT NULL                                                   , -- Impacted customer count
    outage_start                   TIMESTAMP       NOT NULL                                                     -- Outage start
);

CREATE TABLE tbl_smart_meters (
    meter_id                       INT             PRIMARY KEY                                                , -- Meter primary key ID
    substation_id                  INT             NOT NULL REFERENCES tbl_substations(substation_id)         , -- FK to tbl_substations
    meter_serial_number            VARCHAR(30)     NOT NULL                                                     -- Hardware serial number
);

CREATE TABLE tbl_substations (
    substation_id                  INT             PRIMARY KEY                                                , -- Substation primary key ID
    grid_code                      VARCHAR(20)     NOT NULL                                                   , -- Grid station code
    region_name                    VARCHAR(50)     NOT NULL                                                     -- Service region
);

CREATE TABLE tbl_guest_feedback (
    feedback_id                    INT             PRIMARY KEY                                                , -- Feedback primary key ID
    reservation_id                 INT             NOT NULL REFERENCES tbl_reservations(reservation_id)       , -- FK to tbl_reservations
    cleanliness_score              INT             NOT NULL                                                   , -- Score 1-10
    staff_score                    INT             NOT NULL                                                     -- Score 1-10
);
