-- ========================================================
-- Master DDL Schema Script for Dataset_10_ConnectedConsumer_LifeServices_Digital_20x30_target
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 30
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_10_Digital_Streaming_Media_Dataset, Dataset_13_Event_Ticketing_Platform_Dataset, Dataset_14_Fitness_Wearable_IoT_Dataset, Dataset_15_Food_Delivery_App_Dataset, Dataset_24_Ride_Sharing_Transit_Dataset, Dataset_26_Social_Media_Platform_Dataset
-- ========================================================

CREATE TABLE dim_customer (
    customer_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_customer_id             INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Name
);

CREATE TABLE dim_restaurant (
    restaurant_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_restaurant_id           INT             NOT NULL                                                   , -- Natural ID
    restaurant_name                VARCHAR(100)    NOT NULL                                                     -- Name
);

CREATE TABLE dim_rider (
    rider_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_rider_id                INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Name
);

CREATE TABLE fact_delivery_orders (
    order_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    restaurant_key                 BIGINT          NOT NULL REFERENCES dim_restaurant(restaurant_key)         , -- FK to dim_restaurant
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customer(customer_key)             , -- FK to dim_customer
    rider_key                      BIGINT          NOT NULL REFERENCES dim_rider(rider_key)                   , -- FK to dim_rider
    total_amount_usd               NUMERIC(10,2)   NOT NULL                                                     -- Total USD
);

CREATE TABLE dim_driver (
    driver_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_driver_id               INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE dim_passenger (
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

CREATE TABLE dim_post (
    post_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_post_id                 INT             NOT NULL                                                   , -- Natural ID
    user_key                       BIGINT          NOT NULL REFERENCES dim_user(user_key)                       -- FK to dim_user
);

CREATE TABLE dim_user (
    user_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_user_id                 INT             NOT NULL                                                   , -- Natural ID
    username                       VARCHAR(30)     NOT NULL                                                     -- Username
);

CREATE TABLE fact_post_engagement (
    engagement_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate key
    post_key                       BIGINT          NOT NULL REFERENCES dim_post(post_key)                     , -- FK to dim_post
    user_key                       BIGINT          NOT NULL REFERENCES dim_user(user_key)                       -- FK to dim_user
);

CREATE TABLE fact_social_graph (
    graph_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    follower_user_key              BIGINT          NOT NULL REFERENCES dim_user(user_key)                     , -- FK to dim_user
    followed_user_key              BIGINT          NOT NULL REFERENCES dim_user(user_key)                       -- FK to dim_user
);

CREATE TABLE dim_device (
    device_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_device_id               INT             NOT NULL                                                   , -- Natural ID
    model_name                     VARCHAR(50)     NOT NULL                                                     -- Model name
);

CREATE TABLE dim_user_fitness (
    user_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_user_id                 INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE fact_telemetry_reads (
    telemetry_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate key
    device_key                     BIGINT          NOT NULL REFERENCES dim_device(device_key)                 , -- FK to dim_device
    bpm_value                      INT             NOT NULL                                                     -- BPM
);

CREATE TABLE fact_workout_summary (
    workout_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    user_key                       BIGINT          NOT NULL REFERENCES dim_user(user_key)                     , -- FK to dim_user
    calories_burned                INT             NOT NULL                                                     -- Calories burned
);

CREATE TABLE dim_event (
    event_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_event_id                INT             NOT NULL                                                   , -- Natural ID
    venue_key                      BIGINT          NOT NULL REFERENCES dim_venue(venue_key)                   , -- FK to dim_venue
    event_title                    VARCHAR(100)    NOT NULL                                                     -- Event title
);

CREATE TABLE dim_venue (
    venue_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_venue_id                INT             NOT NULL                                                   , -- Natural ID
    venue_name                     VARCHAR(80)     NOT NULL                                                     -- Venue name
);

CREATE TABLE fact_ticket_sales (
    sale_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    event_key                      BIGINT          NOT NULL REFERENCES dim_event(event_key)                   , -- FK to dim_event
    quantity                       INT             NOT NULL                                                     -- Quantity
);

CREATE TABLE dim_creator (
    creator_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_creator_id              INT             NOT NULL                                                   , -- Natural ID
    creator_name                   VARCHAR(100)    NOT NULL                                                     -- Creator name
);

CREATE TABLE dim_media (
    media_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_media_id                INT             NOT NULL                                                   , -- Natural ID
    creator_key                    BIGINT          NOT NULL REFERENCES dim_creator(creator_key)               , -- FK to dim_creator
    title                          VARCHAR(120)    NOT NULL                                                   , -- Media title
    media_type                     VARCHAR(20)     NOT NULL                                                     -- Media type
);

CREATE TABLE dim_subscriber (
    user_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_user_id                 INT             NOT NULL                                                   , -- Natural ID
    username                       VARCHAR(50)     NOT NULL                                                     -- Username
);

CREATE TABLE fact_stream_events (
    stream_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    user_key                       BIGINT          NOT NULL REFERENCES dim_subscriber(user_key)               , -- FK to dim_subscriber
    media_key                      BIGINT          NOT NULL REFERENCES dim_media(media_key)                   , -- FK to dim_media
    streamed_seconds               INT             NOT NULL                                                     -- Streamed seconds
);

CREATE TABLE fact_subscription_revenue (
    revenue_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    user_key                       BIGINT          NOT NULL REFERENCES dim_subscriber(user_key)               , -- FK to dim_subscriber
    amount_usd                     NUMERIC(8,2)    NOT NULL                                                     -- Monthly amount USD
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
