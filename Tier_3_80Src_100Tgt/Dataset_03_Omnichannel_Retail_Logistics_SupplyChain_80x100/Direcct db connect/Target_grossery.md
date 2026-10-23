# Business Data Glossary - Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_80x100_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_80x100_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_80x100
- **Component**: Target Database Schema (Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_80x100_target)
- **Tier Specification**: Tier 3: 80 Source Tables, 100 Target Tables
- **Total Target Tables**: 100
- **Theme Focus**: Omnichannel Retail, Global Logistics, Freight & Food Delivery
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

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

### Table: `dim_carrier`
**Description**: Domain table for `dim_carrier` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `carrier_key` | **Carrier Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_carrier_id` | **Source Carrier Id** | `INT` | `NOT NULL` | Source natural ID |
| `carrier_name` | **Carrier Name** | `VARCHAR(80)` | `NOT NULL` | Provider name |
| `transport_mode` | **Transport Mode** | `VARCHAR(20)` | `NOT NULL` | Transport mode |

---

---

### Table: `dim_supplier`
**Description**: Domain table for `dim_supplier` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `supplier_key` | **Supplier Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_supplier_id` | **Source Supplier Id** | `INT` | `NOT NULL` | Source natural ID |
| `supplier_name` | **Supplier Name** | `VARCHAR(100)` | `NOT NULL` | Vendor legal name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO country |

---

---

### Table: `dim_warehouse`
**Description**: Domain table for `dim_warehouse` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_warehouse_id` | **Source Warehouse Id** | `INT` | `NOT NULL` | Source natural ID |
| `facility_name` | **Facility Name** | `VARCHAR(80)` | `NOT NULL` | Facility name |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | Location city |

---

---

### Table: `fact_customs_events`
**Description**: Domain table for `fact_customs_events` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customs_key` | **Customs Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_shipment |
| `duty_amount_usd` | **Duty Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Import duty USD |

---

---

### Table: `fact_freight_billing`
**Description**: Domain table for `fact_freight_billing` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `freight_bill_key` | **Freight Bill Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_shipment |
| `freight_charge_usd` | **Freight Charge Usd** | `NUMERIC(10,2)` | `NOT NULL` | Freight cost USD |

---

---

### Table: `fact_inventory_snapshot_supply_supply`
**Description**: Domain table for `fact_inventory_snapshot_supply` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `inventory_key` | **Inventory Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_warehouse |
| `sku_code` | **Sku Code** | `VARCHAR(30)` | `NOT NULL` | Material SKU |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Stock count |

---

---

### Table: `fact_purchase_order`
**Description**: Domain table for `fact_purchase_order` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `po_fact_key` | **Po Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `supplier_key` | **Supplier Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_supplier |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_warehouse |
| `po_number` | **Po Number** | `VARCHAR(30)` | `NOT NULL` | Document number |
| `total_cost_usd` | **Total Cost Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total PO cost USD |

---

---

### Table: `fact_shipment`
**Description**: Domain table for `fact_shipment` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_key` | **Shipment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `po_fact_key` | **Po Fact Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_purchase_order |
| `carrier_key` | **Carrier Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_carrier |
| `tracking_number` | **Tracking Number** | `VARCHAR(40)` | `NOT NULL` | Tracking ref |

---

---

### Table: `dim_port`
**Description**: Domain table for `dim_port` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `port_key` | **Port Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for port dimension |
| `source_port_id` | **Source Port Id** | `INT` | `NOT NULL` | Natural port ID from source |
| `port_code` | **Port Code** | `VARCHAR(10)` | `NOT NULL` | UN/LOCODE port code |
| `port_name` | **Port Name** | `VARCHAR(80)` | `NOT NULL` | Port terminal name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | Country code ISO-3 |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |
| `terminal_operator` | **Terminal Operator** | `VARCHAR(80)` | `NOT NULL` | Operator name |
| `latitude` | **Latitude** | `NUMERIC(8,4)` | `NOT NULL` | Latitude |
| `longitude` | **Longitude** | `NUMERIC(8,4)` | `NOT NULL` | Longitude |
| `berth_capacity` | **Berth Capacity** | `INT` | `NOT NULL` | Berth count |
| `annual_teu_capacity` | **Annual Teu Capacity** | `INT` | `NOT NULL` | TEU capacity |
| `water_depth_meters` | **Water Depth Meters** | `NUMERIC(4,1)` | `NOT NULL` | Depth meters |
| `is_deepwater_flag` | **Is Deepwater Flag** | `BOOLEAN` | `NOT NULL` | Deepwater flag |
| `customs_office_flag` | **Customs Office Flag** | `BOOLEAN` | `NOT NULL` | Customs office flag |
| `operating_hours` | **Operating Hours** | `VARCHAR(30)` | `NOT NULL` | Operating schedule |
| `security_level` | **Security Level** | `VARCHAR(15)` | `NOT NULL` | Security level code |
| `contact_phone` | **Contact Phone** | `VARCHAR(20)` | `NOT NULL` | Contact phone |
| `contact_email` | **Contact Email** | `VARCHAR(100)` | `NOT NULL` | Contact email |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_shipment`
**Description**: Domain table for `dim_shipment` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_key` | **Shipment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for shipment dimension |
| `source_shipment_id` | **Source Shipment Id** | `INT` | `NOT NULL` | Natural shipment ID from source |
| `tracking_number` | **Tracking Number** | `VARCHAR(25)` | `NOT NULL` | Tracking waybill number |
| `shipper_id` | **Shipper Id** | `INT` | `NOT NULL` | Shipper ID |
| `consignee_id` | **Consignee Id** | `INT` | `NOT NULL` | Consignee ID |
| `origin_port_code` | **Origin Port Code** | `VARCHAR(10)` | `NOT NULL` | Origin port code |
| `destination_port_code` | **Destination Port Code** | `VARCHAR(10)` | `NOT NULL` | Destination port code |
| `vessel_name` | **Vessel Name** | `VARCHAR(60)` | `NOT NULL` | Vessel name |
| `container_number` | **Container Number** | `VARCHAR(20)` | `NOT NULL` | Container number |
| `shipment_status` | **Shipment Status** | `VARCHAR(30)` | `NOT NULL` | Shipment status text |
| `declared_value_usd` | **Declared Value Usd** | `NUMERIC(12,2)` | `NOT NULL` | Declared value USD |
| `freight_cost_usd` | **Freight Cost Usd** | `NUMERIC(10,2)` | `NOT NULL` | Freight cost USD |
| `gross_weight_kg` | **Gross Weight Kg** | `NUMERIC(10,2)` | `NOT NULL` | Gross weight kg |
| `volume_cbm` | **Volume Cbm** | `NUMERIC(8,2)` | `NOT NULL` | Volume CBM |
| `customs_cleared_flag` | **Customs Cleared Flag** | `BOOLEAN` | `NOT NULL` | Customs cleared flag |
| `hazardous_flag` | **Hazardous Flag** | `BOOLEAN` | `NOT NULL` | Hazmat flag |
| `reefer_temp_c` | **Reefer Temp C** | `NUMERIC(4,1)` | `NOT NULL` | Reefer temp C |
| `departure_date` | **Departure Date** | `DATE` | `NOT NULL` | Departure date |
| `estimated_arrival_date` | **Estimated Arrival Date** | `DATE` | `NOT NULL` | ETA date |
| `actual_arrival_date` | **Actual Arrival Date** | `DATE` | `NOT NULL` | ATA date |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current_record` | **Is Current Record** | `BOOLEAN` | `NOT NULL` | SCD Type 2 current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_vessel`
**Description**: Domain table for `dim_vessel` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vessel_key` | **Vessel Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for vessel dimension |
| `source_vessel_id` | **Source Vessel Id** | `INT` | `NOT NULL` | Natural vessel ID from source |
| `imo_number` | **Imo Number** | `VARCHAR(15)` | `NOT NULL` | IMO ship number |
| `vessel_name` | **Vessel Name** | `VARCHAR(60)` | `NOT NULL` | Vessel name |
| `flag_state` | **Flag State** | `VARCHAR(3)` | `NOT NULL` | Flag state ISO-3 |
| `vessel_type` | **Vessel Type** | `VARCHAR(30)` | `NOT NULL` | Vessel category |
| `build_year` | **Build Year** | `INT` | `NOT NULL` | Build year |
| `dwt_tonnage` | **Dwt Tonnage** | `INT` | `NOT NULL` | DWT tonnage |
| `teu_capacity` | **Teu Capacity** | `INT` | `NOT NULL` | TEU capacity |
| `engine_power_kw` | **Engine Power Kw** | `INT` | `NOT NULL` | Engine power kW |
| `max_speed_knots` | **Max Speed Knots** | `NUMERIC(4,1)` | `NOT NULL` | Max speed knots |
| `owner_company` | **Owner Company** | `VARCHAR(80)` | `NOT NULL` | Owner company |
| `operator_company` | **Operator Company** | `VARCHAR(80)` | `NOT NULL` | Operator company |
| `call_sign` | **Call Sign** | `VARCHAR(10)` | `NOT NULL` | Call sign |
| `mmsi_number` | **Mmsi Number** | `VARCHAR(15)` | `NOT NULL` | MMSI number |
| `safety_cert_expiry` | **Safety Cert Expiry** | `DATE` | `NOT NULL` | Cert expiry date |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | Operational status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_customs_duties`
**Description**: Domain table for `fact_customs_duties` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customs_key` | **Customs Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for customs fact |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_shipment |
| `port_key` | **Port Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_port |
| `entry_date` | **Entry Date** | `DATE` | `NOT NULL` | Customs entry date |
| `clearance_date` | **Clearance Date** | `DATE` | `NOT NULL` | Customs clearance date |
| `declared_cargo_value_usd` | **Declared Cargo Value Usd** | `NUMERIC(12,2)` | `NOT NULL` | Declared value USD |
| `assessed_duty_usd` | **Assessed Duty Usd** | `NUMERIC(10,2)` | `NOT NULL` | Customs duty USD |
| `import_vat_usd` | **Import Vat Usd** | `NUMERIC(10,2)` | `NOT NULL` | Import VAT USD |
| `excise_tax_usd` | **Excise Tax Usd** | `NUMERIC(8,2)` | `NOT NULL` | Excise tax USD |
| `total_duties_taxes_usd` | **Total Duties Taxes Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total tax & duties USD |
| `customs_risk_score` | **Customs Risk Score** | `INT` | `NOT NULL` | Automated risk score 1-100 |
| `inspection_required_flag` | **Inspection Required Flag** | `BOOLEAN` | `NOT NULL` | Physical inspection flag |
| `inspection_status` | **Inspection Status** | `VARCHAR(30)` | `NOT NULL` | Inspection status text |
| `exemption_claimed_flag` | **Exemption Claimed Flag** | `BOOLEAN` | `NOT NULL` | Duty exemption flag |
| `customs_status_code` | **Customs Status Code** | `VARCHAR(20)` | `NOT NULL` | Customs status |
| `clearance_days` | **Clearance Days** | `INT` | `NOT NULL` | Days to clear customs |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Customs processing comments |

---

---

### Table: `fact_freight_movements`
**Description**: Domain table for `fact_freight_movements` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `movement_key` | **Movement Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for movement fact |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_shipment |
| `origin_port_key` | **Origin Port Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_port |
| `dest_port_key` | **Dest Port Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_port |
| `vessel_key` | **Vessel Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_vessel |
| `departure_date` | **Departure Date** | `DATE` | `NOT NULL` | Departure date key |
| `arrival_date` | **Arrival Date** | `DATE` | `NOT NULL` | Arrival date key |
| `transit_days` | **Transit Days** | `INT` | `NOT NULL` | Total transit duration days |
| `freight_cost_usd` | **Freight Cost Usd** | `NUMERIC(10,2)` | `NOT NULL` | Freight cost USD |
| `insurance_cost_usd` | **Insurance Cost Usd** | `NUMERIC(8,2)` | `NOT NULL` | Cargo insurance cost USD |
| `bunker_surcharge_usd` | **Bunker Surcharge Usd** | `NUMERIC(8,2)` | `NOT NULL` | Fuel surcharge USD |
| `port_handling_fee_usd` | **Port Handling Fee Usd** | `NUMERIC(8,2)` | `NOT NULL` | Terminal handling charge USD |
| `total_transport_usd` | **Total Transport Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total transportation cost USD |
| `gross_weight_kg` | **Gross Weight Kg** | `NUMERIC(10,2)` | `NOT NULL` | Weight kg |
| `volume_cbm` | **Volume Cbm** | `NUMERIC(8,2)` | `NOT NULL` | Volume CBM |
| `on_time_delivery_flag` | **On Time Delivery Flag** | `BOOLEAN` | `NOT NULL` | On-time delivery performance flag |
| `delay_reason_code` | **Delay Reason Code** | `VARCHAR(30)` | `NOT NULL` | Delay reason code or NONE |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_customer`
**Description**: Domain table for `dim_customer` in `Food_Delivery_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_key` | **Customer Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_customer_id` | **Source Customer Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Name |

---

---

### Table: `dim_restaurant`
**Description**: Domain table for `dim_restaurant` in `Food_Delivery_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `restaurant_key` | **Restaurant Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_restaurant_id` | **Source Restaurant Id** | `INT` | `NOT NULL` | Natural ID |
| `restaurant_name` | **Restaurant Name** | `VARCHAR(100)` | `NOT NULL` | Name |

---

---

### Table: `dim_rider`
**Description**: Domain table for `dim_rider` in `Food_Delivery_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `rider_key` | **Rider Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_rider_id` | **Source Rider Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Name |

---

---

### Table: `fact_delivery_orders`
**Description**: Domain table for `fact_delivery_orders` in `Food_Delivery_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_key` | **Order Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `restaurant_key` | **Restaurant Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_restaurant |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer |
| `rider_key` | **Rider Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_rider |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Total USD |

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

---

### Table: `fhir_family_member_history`
**Description**: Domain table for `fhir_family_member_history` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fam_hist_key` | **Fam Hist Key** | `BIGINT` | `PRIMARY KEY` | Family history surrogate key |
| `source_history_id` | **Source History Id** | `INT` | `NOT NULL` | Source natural history ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `condition_display` | **Condition Display** | `VARCHAR(100)` | `NOT NULL` | Condition display name |
| `onset_date` | **Onset Date** | `DATE` | `NOT NULL` | Onset date |

---

---

### Table: `fhir_immunization`
**Description**: Domain table for `fhir_immunization` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `immunization_key` | **Immunization Key** | `BIGINT` | `PRIMARY KEY` | Immunization surrogate key |
| `source_immunization_id` | **Source Immunization Id** | `INT` | `NOT NULL` | Source natural immunization ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `vaccine_code` | **Vaccine Code** | `VARCHAR(20)` | `NOT NULL` | CVX vaccine code |
| `vaccine_display` | **Vaccine Display** | `VARCHAR(100)` | `NOT NULL` | Vaccine display title |
| `occurrence_date` | **Occurrence Date** | `DATE` | `NOT NULL` | Administered date |

---

---

### Table: `fhir_location_bed`
**Description**: Domain table for `fhir_location_bed` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `location_key` | **Location Key** | `BIGINT` | `PRIMARY KEY` | Location surrogate key |
| `source_allocation_id` | **Source Allocation Id** | `INT` | `NOT NULL` | Source natural allocation ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `room_name` | **Room Name** | `VARCHAR(20)` | `NOT NULL` | Room designation |
| `bed_name` | **Bed Name** | `VARCHAR(10)` | `NOT NULL` | Bed designation |
| `start_timestamp` | **Start Timestamp** | `TIMESTAMP` | `NOT NULL` | Assignment start timestamp |

---

---

### Table: `fhir_medication_inventory`
**Description**: Domain table for `fhir_medication_inventory` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `med_inv_key` | **Med Inv Key** | `BIGINT` | `PRIMARY KEY` | Medication inventory surrogate key |
| `source_inventory_id` | **Source Inventory Id** | `INT` | `NOT NULL` | Source natural inventory ID |
| `ndc_code` | **Ndc Code** | `VARCHAR(20)` | `NOT NULL` | NDC code |
| `medication_display` | **Medication Display** | `VARCHAR(100)` | `NOT NULL` | Medication trade name |
| `stock_quantity` | **Stock Quantity** | `INT` | `NOT NULL` | Stock count |
| `reorder_threshold` | **Reorder Threshold** | `INT` | `NOT NULL` | Reorder threshold |

---

---

### Table: `fhir_medication_request`
**Description**: Domain table for `fhir_medication_request` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `med_req_key` | **Med Req Key** | `BIGINT` | `PRIMARY KEY` | Medication request surrogate key |
| `source_prescription_id` | **Source Prescription Id** | `INT` | `NOT NULL` | Source natural prescription ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `rxnorm_code` | **Rxnorm Code** | `VARCHAR(20)` | `NOT NULL` | RxNorm medication code |
| `medication_display` | **Medication Display** | `VARCHAR(100)` | `NOT NULL` | Medication display name |
| `dosage_instruction` | **Dosage Instruction** | `VARCHAR(100)` | `NOT NULL` | Dosage instruction text |
| `authored_on` | **Authored On** | `DATE` | `NOT NULL` | Prescription order date |

---

---

### Table: `fhir_observation_lab`
**Description**: Domain table for `fhir_observation_lab` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `obs_lab_key` | **Obs Lab Key** | `BIGINT` | `PRIMARY KEY` | Lab observation surrogate key |
| `source_lab_result_id` | **Source Lab Result Id** | `INT` | `NOT NULL` | Source natural lab result ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `loinc_code` | **Loinc Code** | `VARCHAR(20)` | `NOT NULL` | LOINC lab code |
| `observation_display` | **Observation Display** | `VARCHAR(100)` | `NOT NULL` | Lab test display name |
| `value_quantity` | **Value Quantity** | `NUMERIC(10,2)` | `NOT NULL` | Lab reading value |
| `unit_code` | **Unit Code** | `VARCHAR(20)` | `NOT NULL` | Unit of measure |
| `issued_timestamp` | **Issued Timestamp** | `TIMESTAMP` | `NOT NULL` | Issue timestamp |

---

---

### Table: `fhir_observation_vitals`
**Description**: Domain table for `fhir_observation_vitals` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `obs_vital_key` | **Obs Vital Key** | `BIGINT` | `PRIMARY KEY` | Vital sign surrogate key |
| `source_vital_id` | **Source Vital Id** | `INT` | `NOT NULL` | Source natural vital ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `vital_display` | **Vital Display** | `VARCHAR(30)` | `NOT NULL` | Vital display category |
| `value_quantity` | **Value Quantity** | `NUMERIC(8,2)` | `NOT NULL` | Measurement reading |
| `unit_code` | **Unit Code** | `VARCHAR(20)` | `NOT NULL` | Unit code |
| `effective_timestamp` | **Effective Timestamp** | `TIMESTAMP` | `NOT NULL` | Observation timestamp |

---

---

### Table: `fhir_organization_dept`
**Description**: Domain table for `fhir_organization_dept` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dept_key` | **Dept Key** | `BIGINT` | `PRIMARY KEY` | Organization surrogate key |
| `source_department_id` | **Source Department Id** | `INT` | `NOT NULL` | Source natural department ID |
| `dept_name` | **Dept Name** | `VARCHAR(60)` | `NOT NULL` | Department designation |
| `facility_name` | **Facility Name** | `VARCHAR(80)` | `NOT NULL` | Hospital facility complex |

---

---

### Table: `fhir_patient`
**Description**: Domain table for `fhir_patient` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fhir_patient_key` | **Fhir Patient Key** | `BIGINT` | `PRIMARY KEY` | FHIR patient surrogate key |
| `source_patient_id` | **Source Patient Id** | `INT` | `NOT NULL` | Source natural patient ID |
| `mrn_identifier` | **Mrn Identifier** | `VARCHAR(30)` | `NOT NULL` | Medical Record Number MRN |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full patient name |
| `gender_code` | **Gender Code** | `VARCHAR(1)` | `NOT NULL` | Administrative gender (M/F/U) |
| `birth_date` | **Birth Date** | `DATE` | `NOT NULL` | Patient date of birth |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City location |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/province code |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | FHIR active record flag |

---

---

### Table: `fhir_patient_contact`
**Description**: Domain table for `fhir_patient_contact` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `contact_key` | **Contact Key** | `BIGINT` | `PRIMARY KEY` | Patient contact surrogate key |
| `source_contact_id` | **Source Contact Id** | `INT` | `NOT NULL` | Source natural contact ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `contact_name` | **Contact Name** | `VARCHAR(60)` | `NOT NULL` | Contact full name |
| `relationship_code` | **Relationship Code** | `VARCHAR(30)` | `NOT NULL` | Relationship type |
| `telecom_phone` | **Telecom Phone** | `VARCHAR(20)` | `NOT NULL` | Contact phone |

---

---

### Table: `fhir_practitioner`
**Description**: Domain table for `fhir_practitioner` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `PRIMARY KEY` | Practitioner surrogate key |
| `source_physician_id` | **Source Physician Id** | `INT` | `NOT NULL` | Source natural physician ID |
| `npi_number` | **Npi Number** | `VARCHAR(10)` | `NOT NULL` | National Provider Identifier NPI |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Practitioner full name |
| `specialty_name` | **Specialty Name** | `VARCHAR(60)` | `NOT NULL` | Medical specialty |
| `dept_key` | **Dept Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_organization_dept |

---

---

### Table: `fhir_practitioner_role`
**Description**: Domain table for `fhir_practitioner_role` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `role_key` | **Role Key** | `BIGINT` | `PRIMARY KEY` | Practitioner role surrogate key |
| `source_staff_id` | **Source Staff Id** | `INT` | `NOT NULL` | Source natural staff ID |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `dept_key` | **Dept Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_organization_dept |
| `role_code` | **Role Code** | `VARCHAR(50)` | `NOT NULL` | Staff role designation |

---

---

### Table: `fhir_procedure`
**Description**: Domain table for `fhir_procedure` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `procedure_key` | **Procedure Key** | `BIGINT` | `PRIMARY KEY` | Procedure surrogate key |
| `source_procedure_id` | **Source Procedure Id** | `INT` | `NOT NULL` | Source natural procedure ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `cpt_code` | **Cpt Code** | `VARCHAR(20)` | `NOT NULL` | CPT procedure code |
| `procedure_display` | **Procedure Display** | `VARCHAR(100)` | `NOT NULL` | Procedure display title |
| `performed_date` | **Performed Date** | `DATE` | `NOT NULL` | Performed date |

---

---

### Table: `fhir_service_request`
**Description**: Domain table for `fhir_service_request` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `service_req_key` | **Service Req Key** | `BIGINT` | `PRIMARY KEY` | Service request surrogate key |
| `source_lab_order_id` | **Source Lab Order Id** | `INT` | `NOT NULL` | Source natural lab order ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `loinc_code` | **Loinc Code** | `VARCHAR(20)` | `NOT NULL` | LOINC concept code |
| `service_display` | **Service Display** | `VARCHAR(100)` | `NOT NULL` | Service display title |
| `authored_on` | **Authored On** | `TIMESTAMP` | `NOT NULL` | Order timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Status code |

---

---

### Table: `dim_accounts`
**Description**: Domain table for `dim_accounts` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `account_key` | **Account Key** | `BIGINT` | `PRIMARY KEY` | Account surrogate key |
| `source_account_id` | **Source Account Id** | `INT` | `NOT NULL` | Source natural account ID |
| `account_number` | **Account Number** | `VARCHAR(20)` | `NOT NULL` | Standardized account number |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `account_type_name` | **Account Type Name** | `VARCHAR(30)` | `NOT NULL` | Account category name |
| `currency_code` | **Currency Code** | `VARCHAR(3)` | `NOT NULL` | ISO currency code |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | Account active flag |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | DW record creation timestamp |

---

---

### Table: `dim_branches`
**Description**: Domain table for `dim_branches` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `branch_key` | **Branch Key** | `BIGINT` | `PRIMARY KEY` | Branch surrogate key |
| `branch_code` | **Branch Code** | `VARCHAR(10)` | `NOT NULL` | Natural branch code |
| `branch_name` | **Branch Name** | `VARCHAR(60)` | `NOT NULL` | Branch designation name |
| `full_address` | **Full Address** | `VARCHAR(150)` | `NOT NULL` | Full street address |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |
| `state_province` | **State Province** | `VARCHAR(50)` | `NOT NULL` | State/province code |
| `postal_code` | **Postal Code** | `VARCHAR(10)` | `NOT NULL` | ZIP/Postal code |
| `manager_full_name` | **Manager Full Name** | `VARCHAR(60)` | `NOT NULL` | Branch manager full name |
| `is_operational` | **Is Operational** | `BOOLEAN` | `NOT NULL` | Operational boolean flag |

---

---

### Table: `dim_credit_cards`
**Description**: Domain table for `dim_credit_cards` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `card_key` | **Card Key** | `BIGINT` | `PRIMARY KEY` | Credit card surrogate key |
| `account_key` | **Account Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_accounts |
| `masked_card_number` | **Masked Card Number** | `VARCHAR(19)` | `NOT NULL` | Masked card number |
| `card_brand` | **Card Brand** | `VARCHAR(20)` | `NOT NULL` | Card brand network |
| `credit_limit_usd` | **Credit Limit Usd** | `NUMERIC(10,2)` | `NOT NULL` | Credit limit USD |
| `current_balance_usd` | **Current Balance Usd** | `NUMERIC(10,2)` | `NOT NULL` | Current balance USD |
| `expiry_date` | **Expiry Date** | `VARCHAR(7)` | `NOT NULL` | Card expiry MM/YYYY |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | Active status indicator |

---

---

### Table: `dim_customers_finance_finance`
**Description**: Domain table for `dim_customers_finance` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_key` | **Customer Key** | `BIGINT` | `PRIMARY KEY` | Customer surrogate key |
| `source_customer_id` | **Source Customer Id** | `INT` | `NOT NULL` | Source natural customer ID |
| `ssn_tax_id` | **Ssn Tax Id** | `VARCHAR(11)` | `NOT NULL` | Masked tax identifier |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full customer name |
| `primary_email` | **Primary Email** | `VARCHAR(100)` | `NOT NULL` | Standardized email address |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NOT NULL` | Formatted contact phone |
| `kyc_status_name` | **Kyc Status Name** | `VARCHAR(20)` | `NOT NULL` | KYC compliance status |
| `risk_rating_code` | **Risk Rating Code** | `VARCHAR(10)` | `NOT NULL` | Risk tier classification |
| `is_current` | **Is Current** | `BOOLEAN` | `NOT NULL` | SCD Type 2 current record indicator |

---

---

### Table: `dim_portfolios`
**Description**: Domain table for `dim_portfolios` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `portfolio_key` | **Portfolio Key** | `BIGINT` | `PRIMARY KEY` | Portfolio surrogate key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `portfolio_name` | **Portfolio Name** | `VARCHAR(60)` | `NOT NULL` | Portfolio title name |
| `investment_strategy` | **Investment Strategy** | `VARCHAR(30)` | `NOT NULL` | Investment strategy category |
| `total_portfolio_val_usd` | **Total Portfolio Val Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total portfolio value USD |
| `risk_profile` | **Risk Profile** | `VARCHAR(15)` | `NOT NULL` | Risk profile classification |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation ISO timestamp |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | Active boolean flag |

---

---

### Table: `fact_audit_events_finance_finance`
**Description**: Domain table for `fact_audit_events_finance` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `event_key` | **Event Key** | `BIGINT` | `PRIMARY KEY` | Audit event surrogate key |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Operator user string |
| `action_category` | **Action Category** | `VARCHAR(30)` | `NOT NULL` | Action category name |
| `target_entity` | **Target Entity** | `VARCHAR(40)` | `NOT NULL` | Target domain entity |
| `entity_id` | **Entity Id** | `INT` | `NOT NULL` | Natural entity ID |
| `user_ip_address` | **User Ip Address** | `VARCHAR(45)` | `NOT NULL` | User IP address |
| `event_timestamp` | **Event Timestamp** | `TIMESTAMP` | `NOT NULL` | Event ISO timestamp |
| `event_result` | **Event Result** | `VARCHAR(15)` | `NOT NULL` | Event outcome result |

---

---

### Table: `fact_loan_payments`
**Description**: Domain table for `fact_loan_payments` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payment_key` | **Payment Key** | `BIGINT` | `PRIMARY KEY` | Loan payment surrogate key |
| `loan_key` | **Loan Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_loans |
| `payment_timestamp` | **Payment Timestamp** | `TIMESTAMP` | `NOT NULL` | Payment execution timestamp |
| `principal_amount_paid` | **Principal Amount Paid** | `NUMERIC(10,2)` | `NOT NULL` | Principal portion paid USD |
| `interest_amount_paid` | **Interest Amount Paid** | `NUMERIC(10,2)` | `NOT NULL` | Interest portion paid USD |
| `total_amount_paid` | **Total Amount Paid** | `NUMERIC(10,2)` | `NOT NULL` | Total amount paid USD |
| `payment_channel` | **Payment Channel** | `VARCHAR(20)` | `NOT NULL` | Payment method channel |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Payment status |

---

---

### Table: `fact_loans`
**Description**: Domain table for `fact_loans` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `loan_key` | **Loan Key** | `BIGINT` | `PRIMARY KEY` | Loan surrogate key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `loan_type_code` | **Loan Type Code** | `VARCHAR(20)` | `NOT NULL` | Loan category code |
| `principal_amount_usd` | **Principal Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Disbursed principal amount USD |
| `annual_interest_rate` | **Annual Interest Rate** | `NUMERIC(5,2)` | `NOT NULL` | Interest percentage rate |
| `term_months` | **Term Months** | `INT` | `NOT NULL` | Loan term duration in months |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Loan start date |
| `remaining_balance_usd` | **Remaining Balance Usd** | `NUMERIC(12,2)` | `NOT NULL` | Current balance in USD |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Status code |

---

---

### Table: `fact_transactions`
**Description**: Domain table for `fact_transactions` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transaction_key` | **Transaction Key** | `BIGINT` | `PRIMARY KEY` | Transaction surrogate key |
| `account_key` | **Account Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_accounts |
| `transaction_ref` | **Transaction Ref** | `VARCHAR(36)` | `NOT NULL` | Enterprise reference code |
| `txn_type` | **Txn Type** | `VARCHAR(20)` | `NOT NULL` | Transaction classification |
| `transaction_amount_usd` | **Transaction Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Transaction amount in USD |
| `transaction_timestamp` | **Transaction Timestamp** | `TIMESTAMP` | `NOT NULL` | Transaction ISO timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Standardized status code |
| `dim_date_key` | **Dim Date Key** | `INT` | `NOT NULL` | Date key YYYYMMDD |

---

---

### Table: `fact_wire_transfers`
**Description**: Domain table for `fact_wire_transfers` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transfer_key` | **Transfer Key** | `BIGINT` | `PRIMARY KEY` | Transfer surrogate key |
| `source_account_key` | **Source Account Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_accounts |
| `dest_account_number` | **Dest Account Number** | `VARCHAR(34)` | `NOT NULL` | Destination account IBAN |
| `swift_bic_code` | **Swift Bic Code** | `VARCHAR(11)` | `NOT NULL` | Destination SWIFT code |
| `transfer_amount_usd` | **Transfer Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Transfer amount USD |
| `transfer_fee_usd` | **Transfer Fee Usd** | `NUMERIC(8,2)` | `NOT NULL` | Transfer fee USD |
| `transfer_timestamp` | **Transfer Timestamp** | `TIMESTAMP` | `NOT NULL` | Transfer execution timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Status code |

---

---

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

### Table: `dim_aircraft`
**Description**: Domain table for `dim_aircraft` in `Airline_Reservation_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `aircraft_key` | **Aircraft Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_aircraft_id` | **Source Aircraft Id** | `INT` | `NOT NULL` | Natural ID |
| `model_name` | **Model Name** | `VARCHAR(40)` | `NOT NULL` | Model name |

---

---

### Table: `dim_airport`
**Description**: Domain table for `dim_airport` in `Airline_Reservation_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `airport_key` | **Airport Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_airport_id` | **Source Airport Id** | `INT` | `NOT NULL` | Natural ID |
| `iata_code` | **Iata Code** | `VARCHAR(3)` | `NOT NULL` | IATA code |

---

---

### Table: `dim_passenger`
**Description**: Domain table for `dim_passenger` in `Airline_Reservation_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `passenger_key` | **Passenger Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_passenger_id` | **Source Passenger Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `fact_flight_bookings`
**Description**: Domain table for `fact_flight_bookings` in `Airline_Reservation_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `booking_key` | **Booking Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `passenger_key` | **Passenger Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_passenger |
| `ticket_price_usd` | **Ticket Price Usd** | `NUMERIC(8,2)` | `NOT NULL` | Price USD |

---

---

### Table: `dim_client`
**Description**: Domain table for `dim_client` in `Asset_Management_Wealth_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `client_key` | **Client Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_client_id` | **Source Client Id** | `INT` | `NOT NULL` | Natural ID |
| `client_name` | **Client Name** | `VARCHAR(100)` | `NOT NULL` | Client name |

---

---

### Table: `dim_security`
**Description**: Domain table for `dim_security` in `Asset_Management_Wealth_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `security_key` | **Security Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_security_id` | **Source Security Id** | `INT` | `NOT NULL` | Natural ID |
| `ticker_symbol` | **Ticker Symbol** | `VARCHAR(10)` | `NOT NULL` | Ticker |

---

---

### Table: `fact_asset_transactions`
**Description**: Domain table for `fact_asset_transactions` in `Asset_Management_Wealth_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transaction_key` | **Transaction Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `client_key` | **Client Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_client |
| `security_key` | **Security Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_security |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Amount USD |

---

---

### Table: `fact_portfolio_holdings`
**Description**: Domain table for `fact_portfolio_holdings` in `Asset_Management_Wealth_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `holding_key` | **Holding Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `client_key` | **Client Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_client |
| `security_key` | **Security Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_security |
| `shares_count` | **Shares Count** | `NUMERIC(12,4)` | `NOT NULL` | Shares count |

---

---

### Table: `dim_buyer`
**Description**: Domain table for `dim_buyer` in `Automotive_Dealership_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `buyer_key` | **Buyer Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_buyer_id` | **Source Buyer Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `dim_dealer`
**Description**: Domain table for `dim_dealer` in `Automotive_Dealership_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dealer_key` | **Dealer Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_dealer_id` | **Source Dealer Id** | `INT` | `NOT NULL` | Natural ID |
| `dealer_name` | **Dealer Name** | `VARCHAR(80)` | `NOT NULL` | Dealer name |

---

---

### Table: `dim_vehicle`
**Description**: Domain table for `dim_vehicle` in `Automotive_Dealership_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vehicle_key` | **Vehicle Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_vehicle_id` | **Source Vehicle Id** | `INT` | `NOT NULL` | Natural ID |
| `vin` | **Vin** | `VARCHAR(17)` | `NOT NULL` | VIN |
| `make` | **Make** | `VARCHAR(30)` | `NOT NULL` | Make |
| `model` | **Model** | `VARCHAR(40)` | `NOT NULL` | Model |

---

---

### Table: `fact_car_sales`
**Description**: Domain table for `fact_car_sales` in `Automotive_Dealership_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `sale_key` | **Sale Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `vehicle_key` | **Vehicle Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_vehicle |
| `buyer_key` | **Buyer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_buyer |
| `dealer_key` | **Dealer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_dealer |
| `sale_price_usd` | **Sale Price Usd** | `NUMERIC(10,2)` | `NOT NULL` | Sale price USD |

---

---

### Table: `fact_service_revenue`
**Description**: Domain table for `fact_service_revenue` in `Automotive_Dealership_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `service_key` | **Service Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `vehicle_key` | **Vehicle Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_vehicle |
| `service_cost_usd` | **Service Cost Usd** | `NUMERIC(8,2)` | `NOT NULL` | Service cost USD |

---

---

### Table: `dim_account_compliance`
**Description**: Domain table for `dim_account_compliance` in `Banking_Fraud_Risk_Compliance_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `account_key` | **Account Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for account dimension |
| `source_account_id` | **Source Account Id** | `INT` | `NOT NULL` | Natural account ID from source |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer_risk |
| `account_number` | **Account Number** | `VARCHAR(20)` | `NOT NULL` | Account number string |
| `account_type` | **Account Type** | `VARCHAR(30)` | `NOT NULL` | CHECKING, SAVINGS, CORPORATE, INVESTMENT |
| `currency_code` | **Currency Code** | `VARCHAR(3)` | `NOT NULL` | Currency ISO-3 |
| `opening_date` | **Opening Date** | `DATE` | `NOT NULL` | Account opening date |
| `current_balance_usd` | **Current Balance Usd** | `NUMERIC(14,2)` | `NOT NULL` | Balance USD |
| `overdraft_limit_usd` | **Overdraft Limit Usd** | `NUMERIC(10,2)` | `NOT NULL` | Overdraft limit USD |
| `account_status` | **Account Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE, FROZEN, DORMANT, CLOSED |
| `branch_code` | **Branch Code** | `VARCHAR(15)` | `NOT NULL` | Bank branch code |
| `is_high_risk_flag` | **Is High Risk Flag** | `BOOLEAN` | `NOT NULL` | High risk account flag |
| `aml_monitoring_status` | **Aml Monitoring Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE, ENHANCED, EXEMPT |
| `last_transaction_date` | **Last Transaction Date** | `DATE` | `NOT NULL` | Last active transaction date |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current` | **Is Current** | `BOOLEAN` | `NOT NULL` | Current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_customer_risk`
**Description**: Domain table for `dim_customer_risk` in `Banking_Fraud_Risk_Compliance_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_key` | **Customer Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for customer risk dimension |
| `source_customer_id` | **Source Customer Id** | `INT` | `NOT NULL` | Natural customer ID from source |
| `customer_number` | **Customer Number** | `VARCHAR(20)` | `NOT NULL` | Customer number |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full legal name |
| `date_of_birth` | **Date Of Birth** | `DATE` | `NOT NULL` | Birth date |
| `is_pep_flag` | **Is Pep Flag** | `BOOLEAN` | `NOT NULL` | PEP flag |
| `sanctions_status` | **Sanctions Status** | `VARCHAR(25)` | `NOT NULL` | Sanctions status text |
| `kyc_status` | **Kyc Status** | `VARCHAR(25)` | `NOT NULL` | KYC status text |
| `kyc_updated_date` | **Kyc Updated Date** | `DATE` | `NOT NULL` | KYC date |
| `risk_rating` | **Risk Rating** | `VARCHAR(15)` | `NOT NULL` | Risk category rating |
| `credit_score` | **Credit Score** | `INT` | `NOT NULL` | Credit score |
| `annual_income_usd` | **Annual Income Usd** | `NUMERIC(12,2)` | `NOT NULL` | Annual income USD |
| `employment_status` | **Employment Status** | `VARCHAR(30)` | `NOT NULL` | Employment status |
| `residence_country` | **Residence Country** | `VARCHAR(3)` | `NOT NULL` | Country ISO-3 |
| `tax_residence_country` | **Tax Residence Country** | `VARCHAR(3)` | `NOT NULL` | FATCA country |
| `active_account_count` | **Active Account Count** | `INT` | `NOT NULL` | Account count |
| `total_balance_usd` | **Total Balance Usd** | `NUMERIC(14,2)` | `NOT NULL` | Total balance USD |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | Customer status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current` | **Is Current** | `BOOLEAN` | `NOT NULL` | SCD Type 2 current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_aml_reports`
**Description**: Domain table for `fact_aml_reports` in `Banking_Fraud_Risk_Compliance_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `sar_fact_key` | **Sar Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for SAR fact |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer_risk |
| `filing_date` | **Filing Date** | `DATE` | `NOT NULL` | Filing date key |
| `fincen_control_number` | **Fincen Control Number** | `VARCHAR(25)` | `NOT NULL` | Control number |
| `suspicious_activity_code` | **Suspicious Activity Code** | `VARCHAR(25)` | `NOT NULL` | Activity code |
| `suspicious_amount_usd` | **Suspicious Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Suspicious amount USD |
| `investigation_days` | **Investigation Days** | `INT` | `NOT NULL` | Days under investigation |
| `law_enforcement_flag` | **Law Enforcement Flag** | `BOOLEAN` | `NOT NULL` | Law enforcement notified flag |
| `account_frozen_flag` | **Account Frozen Flag** | `BOOLEAN` | `NOT NULL` | Account frozen flag |
| `regulatory_body_code` | **Regulatory Body Code** | `VARCHAR(15)` | `NOT NULL` | Regulatory body code |
| `jurisdiction_code` | **Jurisdiction Code** | `VARCHAR(10)` | `NOT NULL` | Jurisdiction code |
| `approval_status` | **Approval Status** | `VARCHAR(20)` | `NOT NULL` | Approval status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_financial_transactions`
**Description**: Domain table for `fact_financial_transactions` in `Banking_Fraud_Risk_Compliance_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transaction_key` | **Transaction Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for transaction fact |
| `sender_customer_key` | **Sender Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer_risk |
| `receiver_customer_key` | **Receiver Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer_risk |
| `sender_account_key` | **Sender Account Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_account_compliance |
| `transaction_reference` | **Transaction Reference** | `VARCHAR(30)` | `NOT NULL` | Transaction reference code |
| `transaction_timestamp` | **Transaction Timestamp** | `TIMESTAMP` | `NOT NULL` | Timestamp key |
| `transaction_type` | **Transaction Type** | `VARCHAR(30)` | `NOT NULL` | Type text |
| `channel_type` | **Channel Type** | `VARCHAR(20)` | `NOT NULL` | Channel text |
| `principal_amount_usd` | **Principal Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Amount USD |
| `fee_amount_usd` | **Fee Amount Usd** | `NUMERIC(8,2)` | `NOT NULL` | Fee USD |
| `total_debit_usd` | **Total Debit Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total debited USD |
| `risk_score_numeric` | **Risk Score Numeric** | `INT` | `NOT NULL` | Risk score 1-100 |
| `fraud_flag` | **Fraud Flag** | `BOOLEAN` | `NOT NULL` | Confirmed fraud flag |
| `cross_border_flag` | **Cross Border Flag** | `BOOLEAN` | `NOT NULL` | Cross border flag |
| `location_country` | **Location Country** | `VARCHAR(3)` | `NOT NULL` | Country ISO-3 |
| `aml_status` | **Aml Status** | `VARCHAR(25)` | `NOT NULL` | AML status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_fraud_alerts`
**Description**: Domain table for `fact_fraud_alerts` in `Banking_Fraud_Risk_Compliance_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `alert_key` | **Alert Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for alert fact |
| `transaction_key` | **Transaction Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_financial_transactions |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer_risk |
| `alert_timestamp` | **Alert Timestamp** | `TIMESTAMP` | `NOT NULL` | Alert timestamp |
| `rule_code` | **Rule Code** | `VARCHAR(20)` | `NOT NULL` | Rule triggered code |
| `rule_name` | **Rule Name** | `VARCHAR(80)` | `NOT NULL` | Rule name text |
| `severity_level` | **Severity Level** | `VARCHAR(15)` | `NOT NULL` | Severity level |
| `anomaly_score` | **Anomaly Score** | `INT` | `NOT NULL` | Anomaly score 1-100 |
| `investigation_status` | **Investigation Status** | `VARCHAR(25)` | `NOT NULL` | Status text |
| `resolution_outcome` | **Resolution Outcome** | `VARCHAR(40)` | `NOT NULL` | Resolution text |
| `is_false_positive_flag` | **Is False Positive Flag** | `BOOLEAN` | `NOT NULL` | False positive flag |
| `sar_filed_flag` | **Sar Filed Flag** | `BOOLEAN` | `NOT NULL` | SAR filed flag |
| `confirmed_loss_usd` | **Confirmed Loss Usd** | `NUMERIC(10,2)` | `NOT NULL` | Loss USD |
| `recovered_funds_usd` | **Recovered Funds Usd** | `NUMERIC(10,2)` | `NOT NULL` | Recovered USD |
| `investigation_hours` | **Investigation Hours** | `NUMERIC(5,1)` | `NOT NULL` | Hours to resolve |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_asset`
**Description**: Domain table for `dim_asset` in `Cryptocurrency_Exchange_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `asset_key` | **Asset Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_asset_id` | **Source Asset Id** | `INT` | `NOT NULL` | Natural ID |
| `ticker_symbol` | **Ticker Symbol** | `VARCHAR(10)` | `NOT NULL` | Ticker |

---

---

### Table: `dim_wallet`
**Description**: Domain table for `dim_wallet` in `Cryptocurrency_Exchange_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `wallet_key` | **Wallet Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_wallet_id` | **Source Wallet Id** | `INT` | `NOT NULL` | Natural ID |
| `asset_key` | **Asset Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_asset |

---

---

### Table: `fact_deposits`
**Description**: Domain table for `fact_deposits` in `Cryptocurrency_Exchange_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `deposit_key` | **Deposit Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `wallet_key` | **Wallet Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_wallet |
| `amount` | **Amount** | `NUMERIC(18,8)` | `NOT NULL` | Amount |

---

---

### Table: `fact_executed_trades`
**Description**: Domain table for `fact_executed_trades` in `Cryptocurrency_Exchange_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `trade_key` | **Trade Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `asset_key` | **Asset Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_asset |
| `trade_volume` | **Trade Volume** | `NUMERIC(18,8)` | `NOT NULL` | Volume |

---

---

### Table: `dim_creator`
**Description**: Domain table for `dim_creator` in `Digital_Streaming_Media_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `creator_key` | **Creator Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_creator_id` | **Source Creator Id** | `INT` | `NOT NULL` | Natural ID |
| `creator_name` | **Creator Name** | `VARCHAR(100)` | `NOT NULL` | Creator name |

---