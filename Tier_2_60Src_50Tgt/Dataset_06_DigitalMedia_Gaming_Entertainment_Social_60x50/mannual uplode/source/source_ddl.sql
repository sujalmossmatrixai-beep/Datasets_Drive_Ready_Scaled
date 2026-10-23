-- ========================================================
-- Master DDL Schema Script for Dataset_06_DigitalMedia_Gaming_Entertainment_Social_60x50_source
-- Tier: Tier 2: 60 Source Tables, 50 Target Tables
-- Total Tables: 60
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_10_Digital_Streaming_Media_Dataset, Dataset_13_Event_Ticketing_Platform_Dataset, Dataset_16_Gaming_Esports_Dataset, Dataset_26_Social_Media_Platform_Dataset
-- ========================================================

CREATE TABLE tbl_content_creators (
    creator_id                     INT             PRIMARY KEY                                                , -- Creator primary key ID
    creator_name                   VARCHAR(100)    NOT NULL                                                   , -- Artist or Studio name
    country_code                   VARCHAR(3)      NOT NULL                                                     -- Country ISO
);

CREATE TABLE tbl_media_catalog (
    media_id                       INT             PRIMARY KEY                                                , -- Media item primary key ID
    creator_id                     INT             NOT NULL REFERENCES tbl_content_creators(creator_id)       , -- FK to tbl_content_creators
    title                          VARCHAR(120)    NOT NULL                                                   , -- Track or Movie title
    media_type                     VARCHAR(20)     NOT NULL                                                   , -- AUDIO/VIDEO/PODCAST
    duration_seconds               INT             NOT NULL                                                     -- Play duration in seconds
);

CREATE TABLE tbl_playlists (
    playlist_id                    INT             PRIMARY KEY                                                , -- Playlist primary key ID
    user_id                        INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    playlist_title                 VARCHAR(80)     NOT NULL                                                     -- Title
);

CREATE TABLE tbl_stream_history (
    stream_id                      INT             PRIMARY KEY                                                , -- Stream primary key ID
    user_id                        INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    media_id                       INT             NOT NULL REFERENCES tbl_media_catalog(media_id)            , -- FK to tbl_media_catalog
    streamed_seconds               INT             NOT NULL                                                   , -- Watched seconds
    streamed_at                    TIMESTAMP       NOT NULL                                                     -- Timestamp
);

CREATE TABLE tbl_subscription_tiers (
    tier_id                        INT             PRIMARY KEY                                                , -- Tier primary key ID
    tier_name                      VARCHAR(40)     NOT NULL                                                   , -- FREE/PREMIUM/FAMILY
    monthly_price                  DECIMAL(8,2)    NOT NULL                                                   , -- Price USD
    max_streams                    INT             NOT NULL                                                     -- Simultaneous streams allowed
);

CREATE TABLE tbl_user_ratings (
    rating_id                      INT             PRIMARY KEY                                                , -- Rating primary key ID
    user_id                        INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    media_id                       INT             NOT NULL REFERENCES tbl_media_catalog(media_id)            , -- FK to tbl_media_catalog
    stars                          INT             NOT NULL                                                     -- Rating 1-5
);

CREATE TABLE tbl_user_subscriptions (
    subscription_id                INT             PRIMARY KEY                                                , -- Subscription primary key ID
    user_id                        INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    tier_id                        INT             NOT NULL REFERENCES tbl_subscription_tiers(tier_id)        , -- FK to tbl_subscription_tiers
    start_date                     DATE            NOT NULL                                                   , -- Start date
    auto_renew                     VARCHAR(1)      NOT NULL                                                     -- Auto-renew Y/N
);

CREATE TABLE tbl_users (
    user_id                        INT             PRIMARY KEY                                                , -- User primary key ID
    username                       VARCHAR(50)     NOT NULL                                                   , -- Unique handle
    email                          VARCHAR(100)    NOT NULL                                                   , -- Contact email
    registration_date              DATE            NOT NULL                                                     -- Sign up date
);

CREATE TABLE tbl_esports_teams (
    team_id                        INT             PRIMARY KEY                                                , -- Team primary key ID
    team_name                      VARCHAR(80)     NOT NULL                                                   , -- Org team name
    region_code                    VARCHAR(10)     NOT NULL                                                     -- NA/EU/APAC
);

CREATE TABLE tbl_ingame_store_items (
    item_id                        INT             PRIMARY KEY                                                , -- Item primary key ID
    item_name                      VARCHAR(80)     NOT NULL                                                   , -- Skin or Cosmetic name
    virtual_currency_cost          INT             NOT NULL                                                     -- Gems or Coins cost
);

CREATE TABLE tbl_match_player_stats (
    stat_id                        INT             PRIMARY KEY                                                , -- Stat primary key ID
    match_id                       INT             NOT NULL REFERENCES tbl_matches(match_id)                  , -- FK to tbl_matches
    player_id                      INT             NOT NULL REFERENCES tbl_players(player_id)                 , -- FK to tbl_players
    kills                          INT             NOT NULL                                                   , -- Eliminations
    deaths                         INT             NOT NULL                                                   , -- Deaths
    assists                        INT             NOT NULL                                                     -- Assists
);

CREATE TABLE tbl_matches (
    match_id                       INT             PRIMARY KEY                                                , -- Match primary key ID
    tournament_id                  INT             NOT NULL REFERENCES tbl_tournaments(tournament_id)         , -- FK to tbl_tournaments
    winning_team_id                INT             NOT NULL REFERENCES tbl_esports_teams(team_id)             , -- FK to tbl_esports_teams
    match_date                     TIMESTAMP       NOT NULL                                                     -- Match timestamp
);

CREATE TABLE tbl_player_purchases (
    purchase_id                    INT             PRIMARY KEY                                                , -- Purchase primary key ID
    player_id                      INT             NOT NULL REFERENCES tbl_players(player_id)                 , -- FK to tbl_players
    item_id                        INT             NOT NULL REFERENCES tbl_ingame_store_items(item_id)        , -- FK to tbl_ingame_store_items
    purchase_date                  TIMESTAMP       NOT NULL                                                     -- Transaction timestamp
);

CREATE TABLE tbl_players (
    player_id                      INT             PRIMARY KEY                                                , -- Player primary key ID
    team_id                        INT             NULL REFERENCES tbl_esports_teams(team_id)                 , -- FK to tbl_esports_teams
    gamer_tag                      VARCHAR(40)     NOT NULL                                                   , -- In-game handle
    rank_title                     VARCHAR(30)     NOT NULL                                                     -- Competitive rank
);

CREATE TABLE tbl_tournaments (
    tournament_id                  INT             PRIMARY KEY                                                , -- Tournament primary key ID
    tournament_name                VARCHAR(100)    NOT NULL                                                   , -- Tournament title
    prize_pool                     DECIMAL(12,2)   NOT NULL                                                     -- Prize money USD
);

CREATE TABLE tbl_event_venues (
    venue_id                       INT             PRIMARY KEY                                                , -- Venue primary key ID
    venue_name                     VARCHAR(80)     NOT NULL                                                   , -- Arena or Stadium name
    city                           VARCHAR(50)     NOT NULL                                                   , -- City
    seating_capacity               INT             NOT NULL                                                     -- Capacity seats
);

CREATE TABLE tbl_events (
    event_id                       INT             PRIMARY KEY                                                , -- Event primary key ID
    venue_id                       INT             NOT NULL REFERENCES tbl_event_venues(venue_id)             , -- FK to tbl_event_venues
    event_title                    VARCHAR(100)    NOT NULL                                                   , -- Concert or Game title
    event_date                     TIMESTAMP       NOT NULL                                                     -- Event date time
);

CREATE TABLE tbl_ticket_purchases (
    purchase_id                    INT             PRIMARY KEY                                                , -- Purchase primary key ID
    tier_id                        INT             NOT NULL REFERENCES tbl_ticket_tiers(tier_id)              , -- FK to tbl_ticket_tiers
    quantity                       INT             NOT NULL                                                   , -- Tickets bought
    purchase_time                  TIMESTAMP       NOT NULL                                                     -- Timestamp
);

CREATE TABLE tbl_ticket_tiers (
    tier_id                        INT             PRIMARY KEY                                                , -- Tier primary key ID
    event_id                       INT             NOT NULL REFERENCES tbl_events(event_id)                   , -- FK to tbl_events
    tier_name                      VARCHAR(30)     NOT NULL                                                   , -- VIP/FLOOR/BALCONY
    ticket_price                   DECIMAL(8,2)    NOT NULL                                                     -- Price USD
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

CREATE TABLE tbl_users_social (
    user_id                        INT             PRIMARY KEY                                                , -- User primary key ID
    username                       VARCHAR(30)     NOT NULL                                                   , -- Unique social tag
    display_name                   VARCHAR(60)     NOT NULL                                                     -- Profile name
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

CREATE TABLE src_patient_billing (
    billing_id                     INT             PRIMARY KEY                                                , -- Patient billing primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    total_charge_amount            DECIMAL(10,2)   NOT NULL                                                   , -- Gross medical charge
    paid_amount                    DECIMAL(10,2)   NOT NULL                                                   , -- Settled payment amount
    balance_due                    DECIMAL(10,2)   NOT NULL                                                   , -- Outstanding invoice balance
    billing_date                   DATE            NOT NULL                                                   , -- Statement generation date
    billing_status                 VARCHAR(15)     NOT NULL                                                     -- BILLED/PAID/OVERDUE
);
