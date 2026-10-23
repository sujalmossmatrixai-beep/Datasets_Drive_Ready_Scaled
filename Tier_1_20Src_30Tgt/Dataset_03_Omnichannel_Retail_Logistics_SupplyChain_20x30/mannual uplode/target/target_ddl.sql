-- ========================================================
-- Master DDL Schema Script for Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_20x30_target
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 30
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_17_Global_Logistics_Shipping_Dataset, Dataset_27_Supply_Chain_Logistics_Dataset
-- ========================================================

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

CREATE TABLE fact_product_reviews (
    fact_review_key                BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    rating_score                   INT             NOT NULL                                                     -- Rating score 1-5
);

CREATE TABLE fact_return_requests (
    fact_return_key                BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    return_status                  VARCHAR(20)     NOT NULL                                                     -- Return status
);

CREATE TABLE fact_shipments (
    fact_shipment_key              BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    carrier_name                   VARCHAR(30)     NOT NULL                                                   , -- Carrier name
    tracking_number                VARCHAR(40)     NOT NULL                                                   , -- Tracking code
    shipment_status                VARCHAR(20)     NOT NULL                                                     -- Shipment status
);

CREATE TABLE fact_shopping_carts (
    fact_cart_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)              -- FK to dim_customers
);

CREATE TABLE fact_support_tickets (
    fact_ticket_key                BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    fact_order_key                 BIGINT          NULL REFERENCES fact_orders(fact_order_key)                , -- FK to fact_orders
    ticket_status                  VARCHAR(20)     NOT NULL                                                     -- Ticket status
);

CREATE TABLE fact_wishlists (
    fact_wishlist_key              BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)               -- FK to dim_products
);

CREATE TABLE dim_carrier (
    carrier_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_carrier_id              INT             NOT NULL                                                   , -- Source natural ID
    carrier_name                   VARCHAR(80)     NOT NULL                                                   , -- Provider name
    transport_mode                 VARCHAR(20)     NOT NULL                                                     -- Transport mode
);

CREATE TABLE dim_supplier (
    supplier_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_supplier_id             INT             NOT NULL                                                   , -- Source natural ID
    supplier_name                  VARCHAR(100)    NOT NULL                                                   , -- Vendor legal name
    country_code                   VARCHAR(3)      NOT NULL                                                     -- ISO country
);

CREATE TABLE dim_warehouse (
    warehouse_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_warehouse_id            INT             NOT NULL                                                   , -- Source natural ID
    facility_name                  VARCHAR(80)     NOT NULL                                                   , -- Facility name
    city_name                      VARCHAR(50)     NOT NULL                                                     -- Location city
);

CREATE TABLE fact_customs_events (
    customs_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    shipment_key                   BIGINT          NOT NULL REFERENCES fact_shipment(shipment_key)            , -- FK to fact_shipment
    duty_amount_usd                NUMERIC(10,2)   NOT NULL                                                     -- Import duty USD
);

CREATE TABLE fact_freight_billing (
    freight_bill_key               BIGINT          PRIMARY KEY                                                , -- Surrogate key
    shipment_key                   BIGINT          NOT NULL REFERENCES fact_shipment(shipment_key)            , -- FK to fact_shipment
    freight_charge_usd             NUMERIC(10,2)   NOT NULL                                                     -- Freight cost USD
);

CREATE TABLE fact_inventory_snapshot_supply (
    inventory_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate key
    warehouse_key                  BIGINT          NOT NULL REFERENCES dim_warehouse(warehouse_key)           , -- FK to dim_warehouse
    sku_code                       VARCHAR(30)     NOT NULL                                                   , -- Material SKU
    quantity_on_hand               INT             NOT NULL                                                     -- Stock count
);

CREATE TABLE fact_purchase_order (
    po_fact_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    supplier_key                   BIGINT          NOT NULL REFERENCES dim_supplier(supplier_key)             , -- FK to dim_supplier
    warehouse_key                  BIGINT          NOT NULL REFERENCES dim_warehouse(warehouse_key)           , -- FK to dim_warehouse
    po_number                      VARCHAR(30)     NOT NULL                                                   , -- Document number
    total_cost_usd                 NUMERIC(12,2)   NOT NULL                                                     -- Total PO cost USD
);

CREATE TABLE fact_shipment (
    shipment_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    po_fact_key                    BIGINT          NOT NULL REFERENCES fact_purchase_order(po_fact_key)       , -- FK to fact_purchase_order
    carrier_key                    BIGINT          NOT NULL REFERENCES dim_carrier(carrier_key)               , -- FK to dim_carrier
    tracking_number                VARCHAR(40)     NOT NULL                                                     -- Tracking ref
);

CREATE TABLE dim_port (
    port_key                       BIGINT          PRIMARY KEY                                              , -- Surrogate key for port dimension
    source_port_id                 INT             NOT NULL                                                 , -- Natural port ID from source
    port_code                      VARCHAR(10)     NOT NULL                                                 , -- UN/LOCODE port code
    port_name                      VARCHAR(80)     NOT NULL                                                 , -- Port terminal name
    country_code                   VARCHAR(3)      NOT NULL                                                 , -- Country code ISO-3
    city_name                      VARCHAR(50)     NOT NULL                                                 , -- City name
    terminal_operator              VARCHAR(80)     NOT NULL                                                 , -- Operator name
    latitude                       NUMERIC(8,4)    NOT NULL                                                 , -- Latitude
    longitude                      NUMERIC(8,4)    NOT NULL                                                 , -- Longitude
    berth_capacity                 INT             NOT NULL                                                 , -- Berth count
    annual_teu_capacity            INT             NOT NULL                                                 , -- TEU capacity
    water_depth_meters             NUMERIC(4,1)    NOT NULL                                                 , -- Depth meters
    is_deepwater_flag              BOOLEAN         NOT NULL                                                 , -- Deepwater flag
    customs_office_flag            BOOLEAN         NOT NULL                                                 , -- Customs office flag
    operating_hours                VARCHAR(30)     NOT NULL                                                 , -- Operating schedule
    security_level                 VARCHAR(15)     NOT NULL                                                 , -- Security level code
    contact_phone                  VARCHAR(20)     NOT NULL                                                 , -- Contact phone
    contact_email                  VARCHAR(100)    NOT NULL                                                 , -- Contact email
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_shipment (
    shipment_key                   BIGINT          PRIMARY KEY                                              , -- Surrogate key for shipment dimension
    source_shipment_id             INT             NOT NULL                                                 , -- Natural shipment ID from source
    tracking_number                VARCHAR(25)     NOT NULL                                                 , -- Tracking waybill number
    shipper_id                     INT             NOT NULL                                                 , -- Shipper ID
    consignee_id                   INT             NOT NULL                                                 , -- Consignee ID
    origin_port_code               VARCHAR(10)     NOT NULL                                                 , -- Origin port code
    destination_port_code          VARCHAR(10)     NOT NULL                                                 , -- Destination port code
    vessel_name                    VARCHAR(60)     NOT NULL                                                 , -- Vessel name
    container_number               VARCHAR(20)     NOT NULL                                                 , -- Container number
    shipment_status                VARCHAR(30)     NOT NULL                                                 , -- Shipment status text
    declared_value_usd             NUMERIC(12,2)   NOT NULL                                                 , -- Declared value USD
    freight_cost_usd               NUMERIC(10,2)   NOT NULL                                                 , -- Freight cost USD
    gross_weight_kg                NUMERIC(10,2)   NOT NULL                                                 , -- Gross weight kg
    volume_cbm                     NUMERIC(8,2)    NOT NULL                                                 , -- Volume CBM
    customs_cleared_flag           BOOLEAN         NOT NULL                                                 , -- Customs cleared flag
    hazardous_flag                 BOOLEAN         NOT NULL                                                 , -- Hazmat flag
    reefer_temp_c                  NUMERIC(4,1)    NOT NULL                                                 , -- Reefer temp C
    departure_date                 DATE            NOT NULL                                                 , -- Departure date
    estimated_arrival_date         DATE            NOT NULL                                                 , -- ETA date
    actual_arrival_date            DATE            NOT NULL                                                 , -- ATA date
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_current_record              BOOLEAN         NOT NULL                                                 , -- SCD Type 2 current record flag
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);
