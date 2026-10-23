-- ========================================================
-- Master DDL Schema Script for Dataset_06_DigitalMedia_Gaming_Entertainment_Social_20x30_target
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 30
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_10_Digital_Streaming_Media_Dataset, Dataset_13_Event_Ticketing_Platform_Dataset, Dataset_16_Gaming_Esports_Dataset, Dataset_26_Social_Media_Platform_Dataset
-- ========================================================

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

CREATE TABLE dim_player (
    player_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_player_id               INT             NOT NULL                                                   , -- Natural ID
    gamer_tag                      VARCHAR(40)     NOT NULL                                                     -- Gamer tag
);

CREATE TABLE dim_team (
    team_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_team_id                 INT             NOT NULL                                                   , -- Natural ID
    team_name                      VARCHAR(80)     NOT NULL                                                     -- Team name
);

CREATE TABLE fact_match_results (
    match_fact_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate key
    winning_team_key               BIGINT          NOT NULL REFERENCES dim_team(team_key)                     , -- FK to dim_team
    match_timestamp                TIMESTAMP       NOT NULL                                                     -- Timestamp
);

CREATE TABLE fact_player_purchases (
    purchase_fact_key              BIGINT          PRIMARY KEY                                                , -- Surrogate key
    player_key                     BIGINT          NOT NULL REFERENCES dim_player(player_key)                 , -- FK to dim_player
    purchase_timestamp             TIMESTAMP       NOT NULL                                                     -- Timestamp
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

CREATE TABLE fact_orders (
    fact_order_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_order_id                INT             NOT NULL                                                   , -- Natural source ID
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    order_number                   VARCHAR(36)     NOT NULL                                                   , -- Order number
    order_date                     TIMESTAMP       NOT NULL                                                   , -- Order date
    order_status                   VARCHAR(20)     NOT NULL                                                   , -- Order status
    total_amount_usd               NUMERIC(12,2)   NOT NULL                                                     -- Gross order total USD
);

CREATE TABLE fact_payments (
    fact_payment_key               BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    payment_method                 VARCHAR(20)     NOT NULL                                                   , -- Method name
    amount_usd                     NUMERIC(12,2)   NOT NULL                                                     -- Payment amount USD
);
