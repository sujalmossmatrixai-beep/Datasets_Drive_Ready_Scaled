-- ========================================================
-- Master DDL Schema Script for Dataset_08_RealEstate_UrbanProperty_Utility_Dealership_60x50_source
-- Tier: Tier 2: 60 Source Tables, 50 Target Tables
-- Total Tables: 60
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_07_Automotive_Dealership_Dataset, Dataset_12_Energy_Smart_Grid_Dataset, Dataset_19_Hotel_Hospitality_Dataset, Dataset_23_Real_Estate_Property_Dataset
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

CREATE TABLE tbl_guests (
    guest_id                       INT             PRIMARY KEY                                                , -- Guest primary key ID
    passport_number                VARCHAR(20)     NOT NULL                                                   , -- Passport or ID number
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- First name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Last name
    country_code                   VARCHAR(3)      NOT NULL                                                     -- Country code
);

CREATE TABLE tbl_hotels (
    hotel_id                       INT             PRIMARY KEY                                                , -- Hotel primary key ID
    hotel_code                     VARCHAR(15)     NOT NULL                                                   , -- Resort or hotel chain code
    hotel_name                     VARCHAR(80)     NOT NULL                                                   , -- Hotel property name
    city                           VARCHAR(50)     NOT NULL                                                   , -- City location
    star_rating                    INT             NOT NULL                                                     -- Star classification 1-5
);

CREATE TABLE tbl_reservations (
    reservation_id                 INT             PRIMARY KEY                                                , -- Reservation primary key ID
    room_id                        INT             NOT NULL REFERENCES tbl_rooms(room_id)                     , -- FK to tbl_rooms
    guest_id                       INT             NOT NULL REFERENCES tbl_guests(guest_id)                   , -- FK to tbl_guests
    check_in_date                  DATE            NOT NULL                                                   , -- Arrival date
    check_out_date                 DATE            NOT NULL                                                   , -- Departure date
    booking_status                 VARCHAR(20)     NOT NULL                                                     -- CONFIRMED/CHECKED_IN/CHECKED_OUT/CANCELLED
);

CREATE TABLE tbl_room_charges (
    charge_id                      INT             PRIMARY KEY                                                , -- Charge primary key ID
    reservation_id                 INT             NOT NULL REFERENCES tbl_reservations(reservation_id)       , -- FK to tbl_reservations
    charge_type                    VARCHAR(30)     NOT NULL                                                   , -- ROOM/ROOM_SERVICE/MINIBAR/SPA
    amount                         DECIMAL(8,2)    NOT NULL                                                     -- Billed amount
);

CREATE TABLE tbl_room_types (
    type_id                        INT             PRIMARY KEY                                                , -- Type primary key ID
    type_name                      VARCHAR(40)     NOT NULL                                                   , -- SINGLE/DOUBLE/SUITE/PRESIDENTIAL
    base_nightly_rate              DECIMAL(8,2)    NOT NULL                                                     -- Base price per night
);

CREATE TABLE tbl_rooms (
    room_id                        INT             PRIMARY KEY                                                , -- Room primary key ID
    hotel_id                       INT             NOT NULL REFERENCES tbl_hotels(hotel_id)                   , -- FK to tbl_hotels
    type_id                        INT             NOT NULL REFERENCES tbl_room_types(type_id)                , -- FK to tbl_room_types
    room_number                    VARCHAR(10)     NOT NULL                                                   , -- Room door number
    floor_number                   INT             NOT NULL                                                     -- Building floor level
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
