-- ========================================================
-- Master DDL Schema Script for Dataset_05_Hospitality_Mobility_Aviation_Fleet_20x30_target
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 30
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_05_Airline_Reservation_Dataset, Dataset_07_Automotive_Dealership_Dataset, Dataset_19_Hotel_Hospitality_Dataset, Dataset_24_Ride_Sharing_Transit_Dataset
-- ========================================================

CREATE TABLE dim_aircraft (
    aircraft_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_aircraft_id             INT             NOT NULL                                                   , -- Natural ID
    model_name                     VARCHAR(40)     NOT NULL                                                     -- Model name
);

CREATE TABLE dim_airport (
    airport_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_airport_id              INT             NOT NULL                                                   , -- Natural ID
    iata_code                      VARCHAR(3)      NOT NULL                                                     -- IATA code
);

CREATE TABLE dim_passenger (
    passenger_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_passenger_id            INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE fact_flight_bookings (
    booking_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    passenger_key                  BIGINT          NOT NULL REFERENCES dim_passenger(passenger_key)           , -- FK to dim_passenger
    ticket_price_usd               NUMERIC(8,2)    NOT NULL                                                     -- Price USD
);

CREATE TABLE dim_guest (
    guest_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_guest_id                INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE dim_hotel (
    hotel_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_hotel_id                INT             NOT NULL                                                   , -- Natural ID
    hotel_name                     VARCHAR(80)     NOT NULL                                                   , -- Hotel name
    city_name                      VARCHAR(50)     NOT NULL                                                     -- City name
);

CREATE TABLE dim_room (
    room_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_room_id                 INT             NOT NULL                                                   , -- Natural ID
    hotel_key                      BIGINT          NOT NULL REFERENCES dim_hotel(hotel_key)                   , -- FK to dim_hotel
    room_number                    VARCHAR(10)     NOT NULL                                                     -- Room number
);

CREATE TABLE fact_reservations (
    reservation_key                BIGINT          PRIMARY KEY                                                , -- Surrogate key
    room_key                       BIGINT          NOT NULL REFERENCES dim_room(room_key)                     , -- FK to dim_room
    guest_key                      BIGINT          NOT NULL REFERENCES dim_guest(guest_key)                   , -- FK to dim_guest
    check_in_date                  DATE            NOT NULL                                                     -- Check in date
);

CREATE TABLE fact_room_charges (
    charge_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    reservation_key                BIGINT          NOT NULL REFERENCES fact_reservations(reservation_key)     , -- FK to fact_reservations
    charge_amount_usd              NUMERIC(8,2)    NOT NULL                                                     -- Amount USD
);

CREATE TABLE dim_driver (
    driver_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_driver_id               INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE dim_passenger_ride (
    passenger_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_passenger_id            INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE fact_driver_earnings (
    payout_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    driver_key                     BIGINT          NOT NULL REFERENCES dim_driver(driver_key)                 , -- FK to dim_driver
    payout_amount_usd              NUMERIC(10,2)   NOT NULL                                                     -- Earnings USD
);

CREATE TABLE fact_ride_trips (
    trip_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    driver_key                     BIGINT          NOT NULL REFERENCES dim_driver(driver_key)                 , -- FK to dim_driver
    passenger_key                  BIGINT          NOT NULL REFERENCES dim_passenger(passenger_key)           , -- FK to dim_passenger
    distance_miles                 NUMERIC(6,2)    NOT NULL                                                     -- Distance miles
);

CREATE TABLE dim_buyer (
    buyer_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_buyer_id                INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE dim_dealer (
    dealer_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_dealer_id               INT             NOT NULL                                                   , -- Natural ID
    dealer_name                    VARCHAR(80)     NOT NULL                                                     -- Dealer name
);

CREATE TABLE dim_vehicle (
    vehicle_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_vehicle_id              INT             NOT NULL                                                   , -- Natural ID
    vin                            VARCHAR(17)     NOT NULL                                                   , -- VIN
    make                           VARCHAR(30)     NOT NULL                                                   , -- Make
    model                          VARCHAR(40)     NOT NULL                                                     -- Model
);

CREATE TABLE fact_car_sales (
    sale_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    vehicle_key                    BIGINT          NOT NULL REFERENCES dim_vehicle(vehicle_key)               , -- FK to dim_vehicle
    buyer_key                      BIGINT          NOT NULL REFERENCES dim_buyer(buyer_key)                   , -- FK to dim_buyer
    dealer_key                     BIGINT          NOT NULL REFERENCES dim_dealer(dealer_key)                 , -- FK to dim_dealer
    sale_price_usd                 NUMERIC(10,2)   NOT NULL                                                     -- Sale price USD
);

CREATE TABLE fact_service_revenue (
    service_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    vehicle_key                    BIGINT          NOT NULL REFERENCES dim_vehicle(vehicle_key)               , -- FK to dim_vehicle
    service_cost_usd               NUMERIC(8,2)    NOT NULL                                                     -- Service cost USD
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
