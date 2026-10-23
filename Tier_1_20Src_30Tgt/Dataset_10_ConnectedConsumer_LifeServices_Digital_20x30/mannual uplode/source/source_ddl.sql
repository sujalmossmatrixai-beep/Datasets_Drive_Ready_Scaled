-- ========================================================
-- Master DDL Schema Script for Dataset_10_ConnectedConsumer_LifeServices_Digital_20x30_source
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 20
-- Domains Included: Dataset_15_Food_Delivery_App_Dataset, Dataset_24_Ride_Sharing_Transit_Dataset, Dataset_26_Social_Media_Platform_Dataset
-- ========================================================

CREATE TABLE tbl_customers (
    customer_id                    INT             PRIMARY KEY                                                , -- Customer primary key ID
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Customer name
    phone                          VARCHAR(20)     NOT NULL                                                     -- Phone number
);

CREATE TABLE tbl_delivery_orders (
    order_id                       INT             PRIMARY KEY                                                , -- Order primary key ID
    restaurant_id                  INT             NOT NULL REFERENCES tbl_restaurants(restaurant_id)         , -- FK to tbl_restaurants
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    rider_id                       INT             NOT NULL REFERENCES tbl_riders(rider_id)                   , -- FK to tbl_riders
    total_amount                   DECIMAL(10,2)   NOT NULL                                                   , -- Order total USD
    order_time                     TIMESTAMP       NOT NULL                                                     -- Placement timestamp
);

CREATE TABLE tbl_delivery_tracking (
    tracking_id                    INT             PRIMARY KEY                                                , -- Tracking primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_delivery_orders(order_id)          , -- FK to tbl_delivery_orders
    pickup_time                    TIMESTAMP       NULL                                                       , -- Restaurant pickup time
    delivered_time                 TIMESTAMP       NULL                                                         -- Customer dropoff time
);

CREATE TABLE tbl_menu_items (
    menu_item_id                   INT             PRIMARY KEY                                                , -- Menu item primary key ID
    restaurant_id                  INT             NOT NULL REFERENCES tbl_restaurants(restaurant_id)         , -- FK to tbl_restaurants
    dish_name                      VARCHAR(100)    NOT NULL                                                   , -- Dish title
    price                          DECIMAL(8,2)    NOT NULL                                                     -- Price USD
);

CREATE TABLE tbl_order_line_items (
    line_item_id                   INT             PRIMARY KEY                                                , -- Line item primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_delivery_orders(order_id)          , -- FK to tbl_delivery_orders
    menu_item_id                   INT             NOT NULL REFERENCES tbl_menu_items(menu_item_id)           , -- FK to tbl_menu_items
    quantity                       INT             NOT NULL                                                     -- Portion quantity
);

CREATE TABLE tbl_restaurants (
    restaurant_id                  INT             PRIMARY KEY                                                , -- Restaurant primary key ID
    restaurant_name                VARCHAR(100)    NOT NULL                                                   , -- Business name
    cuisine_type                   VARCHAR(40)     NOT NULL                                                   , -- Cuisine category (ITALIAN/MEXICAN)
    city                           VARCHAR(50)     NOT NULL                                                     -- City
);

CREATE TABLE tbl_riders (
    rider_id                       INT             PRIMARY KEY                                                , -- Rider primary key ID
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Rider name
    vehicle_type                   VARCHAR(20)     NOT NULL                                                   , -- BICYCLE/SCOOTER/CAR
    rating                         DECIMAL(3,2)    NOT NULL                                                     -- Rider rating 1-5
);

CREATE TABLE tbl_driver_payouts (
    payout_id                      INT             PRIMARY KEY                                                , -- Payout primary key ID
    driver_id                      INT             NOT NULL REFERENCES tbl_drivers(driver_id)                 , -- FK to tbl_drivers
    payout_amount                  DECIMAL(10,2)   NOT NULL                                                     -- Weekly earnings payout
);

CREATE TABLE tbl_driver_vehicles (
    vehicle_id                     INT             PRIMARY KEY                                                , -- Vehicle primary key ID
    driver_id                      INT             NOT NULL REFERENCES tbl_drivers(driver_id)                 , -- FK to tbl_drivers
    license_plate                  VARCHAR(15)     NOT NULL                                                   , -- Plate code
    make_model                     VARCHAR(60)     NOT NULL                                                     -- Car model string
);

CREATE TABLE tbl_drivers (
    driver_id                      INT             PRIMARY KEY                                                , -- Driver primary key ID
    license_number                 VARCHAR(30)     NOT NULL                                                   , -- Drivers license code
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Driver full name
    rating                         DECIMAL(3,2)    NOT NULL                                                     -- Star rating
);

CREATE TABLE tbl_fare_payments (
    fare_id                        INT             PRIMARY KEY                                                , -- Fare primary key ID
    trip_id                        INT             NOT NULL REFERENCES tbl_ride_trips(trip_id)                , -- FK to tbl_ride_trips
    base_fare                      DECIMAL(8,2)    NOT NULL                                                   , -- Base charge
    tip_amount                     DECIMAL(8,2)    NOT NULL                                                     -- Tip amount
);

CREATE TABLE tbl_passengers (
    passenger_id                   INT             PRIMARY KEY                                                , -- Passenger primary key ID
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Full name
    phone                          VARCHAR(20)     NOT NULL                                                     -- Phone number
);

CREATE TABLE tbl_ride_requests (
    request_id                     INT             PRIMARY KEY                                                , -- Request primary key ID
    passenger_id                   INT             NOT NULL REFERENCES tbl_passengers(passenger_id)           , -- FK to tbl_passengers
    pickup_city                    VARCHAR(50)     NOT NULL                                                   , -- City
    requested_time                 TIMESTAMP       NOT NULL                                                     -- Request timestamp
);

CREATE TABLE tbl_ride_trips (
    trip_id                        INT             PRIMARY KEY                                                , -- Trip primary key ID
    request_id                     INT             NOT NULL REFERENCES tbl_ride_requests(request_id)          , -- FK to tbl_ride_requests
    driver_id                      INT             NOT NULL REFERENCES tbl_drivers(driver_id)                 , -- FK to tbl_drivers
    distance_miles                 DECIMAL(6,2)    NOT NULL                                                   , -- Trip length miles
    duration_minutes               INT             NOT NULL                                                     -- Duration in minutes
);

CREATE TABLE tbl_comments (
    comment_id                     INT             PRIMARY KEY                                                , -- Comment primary key ID
    post_id                        INT             NOT NULL REFERENCES tbl_posts(post_id)                     , -- FK to tbl_posts
    user_id                        INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    comment_text                   VARCHAR(255)    NOT NULL                                                     -- Comment message
);

CREATE TABLE tbl_direct_messages (
    message_id                     INT             PRIMARY KEY                                                , -- Message primary key ID
    sender_user_id                 INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    recipient_user_id              INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    message_body                   TEXT            NOT NULL                                                     -- Encrypted chat body
);

CREATE TABLE tbl_post_likes (
    like_id                        INT             PRIMARY KEY                                                , -- Like primary key ID
    post_id                        INT             NOT NULL REFERENCES tbl_posts(post_id)                     , -- FK to tbl_posts
    user_id                        INT             NOT NULL REFERENCES tbl_users(user_id)                       -- FK to tbl_users
);

CREATE TABLE tbl_posts (
    post_id                        INT             PRIMARY KEY                                                , -- Post primary key ID
    user_id                        INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    post_caption                   TEXT            NULL                                                       , -- Post text body
    created_at                     TIMESTAMP       NOT NULL                                                     -- Publish timestamp
);

CREATE TABLE tbl_user_follows (
    follow_id                      INT             PRIMARY KEY                                                , -- Follow primary key ID
    follower_user_id               INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    followed_user_id               INT             NOT NULL REFERENCES tbl_users(user_id)                       -- FK to tbl_users
);

CREATE TABLE tbl_users (
    user_id                        INT             PRIMARY KEY                                                , -- User primary key ID
    username                       VARCHAR(30)     NOT NULL                                                   , -- Unique social tag
    display_name                   VARCHAR(60)     NOT NULL                                                     -- Profile name
);
