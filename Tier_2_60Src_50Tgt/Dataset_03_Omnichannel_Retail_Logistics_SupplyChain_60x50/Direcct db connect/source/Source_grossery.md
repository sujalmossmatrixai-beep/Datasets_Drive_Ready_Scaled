# Business Data Glossary - Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_60x50_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_60x50_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_60x50
- **Component**: Source Database Schema (Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_60x50_source)
- **Tier Specification**: Tier 2: 60 Source Tables, 50 Target Tables
- **Total Source Tables**: 60
- **Theme Focus**: Omnichannel Retail, Global Logistics, Freight & Food Delivery
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `tbl_cart_items`
**Description**: Domain table for `tbl_cart_items` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `cart_item_id` | **Cart Item Id** | `INT` | `PRIMARY KEY` | Cart item primary key ID |
| `cart_id` | **Cart Id** | `INT` | `FOREIGN KEY` | FK to tbl_shopping_carts |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Cart item count quantity |

---

---

### Table: `tbl_categories`
**Description**: Domain table for `tbl_categories` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `category_id` | **Category Id** | `INT` | `PRIMARY KEY` | Category primary key ID |
| `category_name` | **Category Name** | `VARCHAR(50)` | `NOT NULL` | Category display name |
| `category_slug` | **Category Slug** | `VARCHAR(60)` | `NOT NULL` | URL friendly slug |
| `parent_category_id` | **Parent Category Id** | `INT` | `FOREIGN KEY` | Self-referencing parent category |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |

---

---

### Table: `tbl_customer_addresses`
**Description**: Domain table for `tbl_customer_addresses` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `address_id` | **Address Id** | `INT` | `PRIMARY KEY` | Address primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `address_type` | **Address Type** | `VARCHAR(20)` | `NOT NULL` | SHIPPING/BILLING |
| `street_address` | **Street Address** | `VARCHAR(100)` | `NOT NULL` | Street address line |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City location |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/province code |
| `postal_code` | **Postal Code** | `VARCHAR(10)` | `NOT NULL` | ZIP or Postal code |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO 3-letter country code |

---

---

### Table: `tbl_customer_support_tickets`
**Description**: Domain table for `tbl_customer_support_tickets` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `ticket_id` | **Ticket Id** | `INT` | `PRIMARY KEY` | Ticket primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `ticket_subject` | **Ticket Subject** | `VARCHAR(100)` | `NOT NULL` | Issue subject title |
| `ticket_status` | **Ticket Status** | `VARCHAR(20)` | `NOT NULL` | OPEN/RESOLVED/CLOSED |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Opened timestamp |

---

---

### Table: `tbl_customers`
**Description**: Domain table for `tbl_customers` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_id` | **Customer Id** | `INT` | `PRIMARY KEY` | Customer primary key ID |
| `customer_code` | **Customer Code** | `VARCHAR(36)` | `NOT NULL` | Unique tracking code |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Given first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Family last name |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Contact email address |
| `phone` | **Phone** | `VARCHAR(20)` | `NULL` | Telephone contact number |
| `account_status` | **Account Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE/SUSPENDED/CLOSED |
| `customer_segment` | **Customer Segment** | `VARCHAR(30)` | `NOT NULL` | RETAIL/WHOLESALE/VIP |
| `total_spent` | **Total Spent** | `DECIMAL(10,2)` | `NOT NULL` | Lifetime spend amount |
| `loyalty_points` | **Loyalty Points** | `INT` | `NOT NULL` | Earned loyalty points |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Account creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Account updated timestamp |

---

---

### Table: `tbl_discounts_promos`
**Description**: Domain table for `tbl_discounts_promos` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `promo_id` | **Promo Id** | `INT` | `PRIMARY KEY` | Promo primary key ID |
| `promo_code` | **Promo Code** | `VARCHAR(20)` | `NOT NULL` | Unique promo code |
| `discount_percent` | **Discount Percent** | `DECIMAL(5,2)` | `NOT NULL` | Discount percentage rate |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Campaign start date |
| `end_date` | **End Date** | `DATE` | `NOT NULL` | Campaign expiry date |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |

---

---

### Table: `tbl_inventory`
**Description**: Domain table for `tbl_inventory` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `inventory_id` | **Inventory Id** | `INT` | `PRIMARY KEY` | Inventory record primary key ID |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `warehouse_id` | **Warehouse Id** | `INT` | `FOREIGN KEY` | FK to tbl_warehouses |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Available physical stock |
| `reserved_quantity` | **Reserved Quantity** | `INT` | `NOT NULL` | Allocated pending order stock |
| `last_updated` | **Last Updated** | `TIMESTAMP` | `NOT NULL` | Stock check timestamp |

---

---

### Table: `tbl_invoices`
**Description**: Domain table for `tbl_invoices` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `invoice_id` | **Invoice Id** | `INT` | `PRIMARY KEY` | Invoice primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `invoice_number` | **Invoice Number** | `VARCHAR(30)` | `NOT NULL` | Tax invoice document number |
| `invoice_date` | **Invoice Date** | `DATE` | `NOT NULL` | Billing issue date |
| `due_date` | **Due Date** | `DATE` | `NOT NULL` | Payment due date |
| `total_amount` | **Total Amount** | `DECIMAL(10,2)` | `NOT NULL` | Total billed amount |
| `invoice_status` | **Invoice Status** | `VARCHAR(15)` | `NOT NULL` | PAID/UNPAID/OVERDUE |

---

---

### Table: `tbl_order_items`
**Description**: Domain table for `tbl_order_items` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_item_id` | **Order Item Id** | `INT` | `PRIMARY KEY` | Order line item primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `unit_price` | **Unit Price** | `DECIMAL(10,2)` | `NOT NULL` | Sold price per unit |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Purchased item quantity |
| `subtotal` | **Subtotal** | `DECIMAL(10,2)` | `NOT NULL` | Calculated line item subtotal |

---

---

### Table: `tbl_orders`
**Description**: Domain table for `tbl_orders` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_id` | **Order Id** | `INT` | `PRIMARY KEY` | Order primary key ID |
| `order_number` | **Order Number** | `VARCHAR(36)` | `NOT NULL` | Unique transaction order number |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `order_date` | **Order Date** | `TIMESTAMP` | `NOT NULL` | Order placement timestamp |
| `order_status` | **Order Status** | `VARCHAR(20)` | `NOT NULL` | PENDING/PROCESSING/SHIPPED/DELIVERED/CANCELLED |
| `total_amount` | **Total Amount** | `DECIMAL(10,2)` | `NOT NULL` | Gross order total |
| `tax_amount` | **Tax Amount** | `DECIMAL(10,2)` | `NOT NULL` | Applied tax amount |
| `shipping_fee` | **Shipping Fee** | `DECIMAL(10,2)` | `NOT NULL` | Shipping charge fee |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |

---

---

### Table: `tbl_payments`
**Description**: Domain table for `tbl_payments` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payment_id` | **Payment Id** | `INT` | `PRIMARY KEY` | Payment primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `payment_method` | **Payment Method** | `VARCHAR(20)` | `NOT NULL` | CREDIT_CARD/PAYPAL/WIRE |
| `payment_status` | **Payment Status** | `VARCHAR(15)` | `NOT NULL` | COMPLETED/PENDING/FAILED |
| `amount` | **Amount** | `DECIMAL(10,2)` | `NOT NULL` | Processed payment amount |
| `transaction_ref` | **Transaction Ref** | `VARCHAR(36)` | `NOT NULL` | Gateway transaction reference |
| `payment_date` | **Payment Date** | `TIMESTAMP` | `NOT NULL` | Execution timestamp |

---

---

### Table: `tbl_product_attributes`
**Description**: Domain table for `tbl_product_attributes` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `attribute_id` | **Attribute Id** | `INT` | `PRIMARY KEY` | Attribute primary key ID |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `attribute_name` | **Attribute Name** | `VARCHAR(50)` | `NOT NULL` | Color/Size/Weight |
| `attribute_value` | **Attribute Value** | `VARCHAR(50)` | `NOT NULL` | Attribute value string |

---

---

### Table: `tbl_product_reviews`
**Description**: Domain table for `tbl_product_reviews` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `review_id` | **Review Id** | `INT` | `PRIMARY KEY` | Review primary key ID |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `rating_score` | **Rating Score** | `INT` | `NOT NULL` | Rating 1-5 stars |
| `review_text` | **Review Text** | `TEXT` | `NULL` | Customer feedback review |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Review submission timestamp |

---

---

### Table: `tbl_products`
**Description**: Domain table for `tbl_products` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `product_id` | **Product Id** | `INT` | `PRIMARY KEY` | Product primary key ID |
| `sku` | **Sku** | `VARCHAR(30)` | `NOT NULL` | Stock Keeping Unit SKU |
| `product_name` | **Product Name** | `VARCHAR(100)` | `NOT NULL` | Product catalog title |
| `category_id` | **Category Id** | `INT` | `FOREIGN KEY` | FK to tbl_categories |
| `supplier_id` | **Supplier Id** | `INT` | `FOREIGN KEY` | FK to tbl_suppliers |
| `unit_price` | **Unit Price** | `DECIMAL(10,2)` | `NOT NULL` | Standard retail price |
| `cost_price` | **Cost Price** | `DECIMAL(10,2)` | `NOT NULL` | Wholesale cost price |
| `product_status` | **Product Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE/DISCONTINUED/OUT_OF_STOCK |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Catalog entry timestamp |

---

---

### Table: `tbl_return_requests`
**Description**: Domain table for `tbl_return_requests` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `return_id` | **Return Id** | `INT` | `PRIMARY KEY` | Return request primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `return_reason` | **Return Reason** | `VARCHAR(100)` | `NOT NULL` | Reason for return |
| `return_status` | **Return Status** | `VARCHAR(20)` | `NOT NULL` | REQUESTED/APPROVED/REJECTED |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Request timestamp |

---

---

### Table: `tbl_shipments`
**Description**: Domain table for `tbl_shipments` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_id` | **Shipment Id** | `INT` | `PRIMARY KEY` | Shipment primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `tracking_number` | **Tracking Number** | `VARCHAR(40)` | `NOT NULL` | Carrier tracking code |
| `carrier_name` | **Carrier Name** | `VARCHAR(30)` | `NOT NULL` | UPS/FEDEX/DHL |
| `shipped_date` | **Shipped Date** | `TIMESTAMP` | `NULL` | Dispatch timestamp |
| `delivery_date` | **Delivery Date** | `TIMESTAMP` | `NULL` | Delivery timestamp |
| `shipment_status` | **Shipment Status** | `VARCHAR(20)` | `NOT NULL` | IN_TRANSIT/DELIVERED/RETURNED |

---

---

### Table: `tbl_shopping_carts`
**Description**: Domain table for `tbl_shopping_carts` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `cart_id` | **Cart Id** | `INT` | `PRIMARY KEY` | Cart primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Cart creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Cart modified timestamp |

---

---

### Table: `tbl_suppliers`
**Description**: Domain table for `tbl_suppliers` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `supplier_id` | **Supplier Id** | `INT` | `PRIMARY KEY` | Supplier primary key ID |
| `company_name` | **Company Name** | `VARCHAR(100)` | `NOT NULL` | Supplier corporate name |
| `contact_name` | **Contact Name** | `VARCHAR(60)` | `NOT NULL` | Primary account manager |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Corporate email address |
| `phone` | **Phone** | `VARCHAR(20)` | `NOT NULL` | Corporate contact phone |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO 3-letter country code |

---

---

### Table: `tbl_system_audit_logs`
**Description**: Domain table for `tbl_system_audit_logs` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `log_id` | **Log Id** | `INT` | `PRIMARY KEY` | Audit log primary key ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Operator user string ID |
| `action_name` | **Action Name** | `VARCHAR(50)` | `NOT NULL` | Action performed |
| `target_entity` | **Target Entity** | `VARCHAR(50)` | `NOT NULL` | Target table name |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Audit timestamp |

---

---

### Table: `tbl_warehouses`
**Description**: Domain table for `tbl_warehouses` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `warehouse_id` | **Warehouse Id** | `INT` | `PRIMARY KEY` | Warehouse primary key ID |
| `warehouse_code` | **Warehouse Code** | `VARCHAR(20)` | `NOT NULL` | Unique warehouse location code |
| `warehouse_name` | **Warehouse Name** | `VARCHAR(80)` | `NOT NULL` | Facility designation name |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | Facility location city |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/Province code |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO 3-letter country code |

---

---

### Table: `tbl_wishlists`
**Description**: Domain table for `tbl_wishlists` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `wishlist_id` | **Wishlist Id** | `INT` | `PRIMARY KEY` | Wishlist primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `added_at` | **Added At** | `TIMESTAMP` | `NOT NULL` | Addition timestamp |

---

---

### Table: `tbl_carrier_fleet`
**Description**: Domain table for `tbl_carrier_fleet` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `carrier_id` | **Carrier Id** | `INT` | `PRIMARY KEY` | Carrier primary key ID |
| `carrier_name` | **Carrier Name** | `VARCHAR(80)` | `NOT NULL` | Logistics provider name |
| `transport_mode` | **Transport Mode** | `VARCHAR(20)` | `NOT NULL` | TRUCK/RAIL/OCEAN/AIR |
| `fleet_size` | **Fleet Size** | `INT` | `NOT NULL` | Active vehicle count |

---

---

### Table: `tbl_customs_clearance`
**Description**: Domain table for `tbl_customs_clearance` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customs_id` | **Customs Id** | `INT` | `PRIMARY KEY` | Customs primary key ID |
| `shipment_id` | **Shipment Id** | `INT` | `FOREIGN KEY` | FK to tbl_shipment_manifests |
| `declaration_number` | **Declaration Number** | `VARCHAR(40)` | `NOT NULL` | Customs declaration ref |
| `duty_amount` | **Duty Amount** | `DECIMAL(10,2)` | `NOT NULL` | Import duty paid |
| `clearance_status` | **Clearance Status** | `VARCHAR(20)` | `NOT NULL` | CLEARED/HELD/INSPECTED |

---

---

### Table: `tbl_freight_bills`
**Description**: Domain table for `tbl_freight_bills` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `bill_id` | **Bill Id** | `INT` | `PRIMARY KEY` | Bill primary key ID |
| `shipment_id` | **Shipment Id** | `INT` | `FOREIGN KEY` | FK to tbl_shipment_manifests |
| `freight_charge` | **Freight Charge** | `DECIMAL(10,2)` | `NOT NULL` | Freight charge |
| `fuel_surcharge` | **Fuel Surcharge** | `DECIMAL(10,2)` | `NOT NULL` | Fuel surcharge |
| `payment_status` | **Payment Status** | `VARCHAR(15)` | `NOT NULL` | UNPAID/PAID/OVERDUE |

---

---

### Table: `tbl_inventory_lots`
**Description**: Domain table for `tbl_inventory_lots` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lot_id` | **Lot Id** | `INT` | `PRIMARY KEY` | Lot primary key ID |
| `warehouse_id` | **Warehouse Id** | `INT` | `FOREIGN KEY` | FK to tbl_warehouses |
| `sku_code` | **Sku Code** | `VARCHAR(30)` | `NOT NULL` | Material SKU |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Stock count |
| `expiry_date` | **Expiry Date** | `DATE` | `NULL` | Expiration date if applicable |

---

---

### Table: `tbl_po_items`
**Description**: Domain table for `tbl_po_items` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `po_item_id` | **Po Item Id** | `INT` | `PRIMARY KEY` | PO line item primary key ID |
| `po_id` | **Po Id** | `INT` | `FOREIGN KEY` | FK to tbl_purchase_orders |
| `sku_code` | **Sku Code** | `VARCHAR(30)` | `NOT NULL` | Material SKU code |
| `ordered_qty` | **Ordered Qty** | `INT` | `NOT NULL` | Ordered quantity |
| `unit_price` | **Unit Price** | `DECIMAL(10,2)` | `NOT NULL` | Unit price |

---

---

### Table: `tbl_purchase_orders`
**Description**: Domain table for `tbl_purchase_orders` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `po_id` | **Po Id** | `INT` | `PRIMARY KEY` | PO primary key ID |
| `po_number` | **Po Number** | `VARCHAR(30)` | `NOT NULL` | Unique PO document number |
| `supplier_id` | **Supplier Id** | `INT` | `FOREIGN KEY` | FK to tbl_suppliers |
| `warehouse_id` | **Warehouse Id** | `INT` | `FOREIGN KEY` | FK to tbl_warehouses |
| `po_date` | **Po Date** | `DATE` | `NOT NULL` | Order placement date |
| `total_cost` | **Total Cost** | `DECIMAL(12,2)` | `NOT NULL` | Gross PO total amount |

---

---

### Table: `tbl_shipment_manifests`
**Description**: Domain table for `tbl_shipment_manifests` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_id` | **Shipment Id** | `INT` | `PRIMARY KEY` | Shipment primary key ID |
| `po_id` | **Po Id** | `INT` | `FOREIGN KEY` | FK to tbl_purchase_orders |
| `carrier_id` | **Carrier Id** | `INT` | `FOREIGN KEY` | FK to tbl_carrier_fleet |
| `tracking_number` | **Tracking Number** | `VARCHAR(40)` | `NOT NULL` | Tracking reference |
| `dispatch_date` | **Dispatch Date** | `TIMESTAMP` | `NOT NULL` | Dispatch timestamp |
| `expected_delivery` | **Expected Delivery** | `DATE` | `NOT NULL` | Estimated arrival date |

---

---

### Table: `tbl_suppliers_supply_supply`
**Description**: Domain table for `tbl_suppliers_supply` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `supplier_id` | **Supplier Id** | `INT` | `PRIMARY KEY` | Supplier primary key ID |
| `supplier_name` | **Supplier Name** | `VARCHAR(100)` | `NOT NULL` | Vendor legal name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | Country ISO code |
| `rating_score` | **Rating Score** | `DECIMAL(3,2)` | `NOT NULL` | Vendor rating 1.0-5.0 |

---

---

### Table: `tbl_warehouse_racks`
**Description**: Domain table for `tbl_warehouse_racks` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `rack_id` | **Rack Id** | `INT` | `PRIMARY KEY` | Rack primary key ID |
| `warehouse_id` | **Warehouse Id** | `INT` | `FOREIGN KEY` | FK to tbl_warehouses |
| `aisle_code` | **Aisle Code** | `VARCHAR(10)` | `NOT NULL` | Aisle designation |
| `shelf_level` | **Shelf Level** | `INT` | `NOT NULL` | Shelf vertical level |

---

---

### Table: `tbl_warehouses_supply_supply`
**Description**: Domain table for `tbl_warehouses_supply` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `warehouse_id` | **Warehouse Id** | `INT` | `PRIMARY KEY` | Warehouse primary key ID |
| `facility_name` | **Facility Name** | `VARCHAR(80)` | `NOT NULL` | Facility designation |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | Location city |
| `capacity_sqft` | **Capacity Sqft** | `INT` | `NOT NULL` | Storage square footage |

---

---

### Table: `tbl_cargo_containers`
**Description**: Domain table for `tbl_cargo_containers` in `Global_Logistics_Shipping_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `container_id` | **Container Id** | `INT` | `PRIMARY KEY` | Container primary key ID |
| `container_number` | **Container Number** | `VARCHAR(20)` | `NOT NULL` | ISO container serial number |
| `container_type` | **Container Type** | `VARCHAR(30)` | `NOT NULL` | DRY_40FT, REEFER_40FT, OPEN_TOP, TANK |
| `length_feet` | **Length Feet** | `INT` | `NOT NULL` | Container length 20ft or 40ft |
| `max_payload_kg` | **Max Payload Kg** | `DECIMAL(10,2)` | `NOT NULL` | Maximum payload capacity kg |
| `tare_weight_kg` | **Tare Weight Kg** | `DECIMAL(8,2)` | `NOT NULL` | Empty container weight kg |
| `manufacture_year` | **Manufacture Year** | `INT` | `NOT NULL` | Year of container build |
| `last_inspection_date` | **Last Inspection Date** | `DATE` | `NOT NULL` | Safety inspection date |
| `current_location_port` | **Current Location Port** | `VARCHAR(10)` | `NOT NULL` | Current port location |
| `is_refrigerated` | **Is Refrigerated** | `BOOLEAN` | `NOT NULL` | Reefer container flag |
| `seal_number` | **Seal Number** | `VARCHAR(20)` | `NOT NULL` | Security seal lock ID |
| `owner_shipping_line` | **Owner Shipping Line** | `VARCHAR(50)` | `NOT NULL` | Container owner shipping line |
| `lease_status` | **Lease Status** | `VARCHAR(20)` | `NOT NULL` | OWNED, LEASED_LONG, LEASED_SHORT |
| `maintenance_status` | **Maintenance Status** | `VARCHAR(20)` | `NOT NULL` | SERVICEABLE, REPAIR_NEEDED, SCRAPPED |
| `gps_tracker_id` | **Gps Tracker Id** | `VARCHAR(25)` | `NOT NULL` | IoT GPS tracker device ID |
| `door_type` | **Door Type** | `VARCHAR(30)` | `NOT NULL` | STANDARD_DOUBLE, ROLL_UP, SIDE_DOOR |
| `inspection_passed_flag` | **Inspection Passed Flag** | `BOOLEAN` | `NOT NULL` | Passed safety inspection |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Container maintenance comments |

---

---

### Table: `tbl_carrier_vessels`
**Description**: Domain table for `tbl_carrier_vessels` in `Global_Logistics_Shipping_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vessel_id` | **Vessel Id** | `INT` | `PRIMARY KEY` | Vessel primary key ID |
| `imo_number` | **Imo Number** | `VARCHAR(15)` | `NOT NULL` | IMO ship identification number |
| `vessel_name` | **Vessel Name** | `VARCHAR(60)` | `NOT NULL` | Ship official name |
| `flag_state` | **Flag State** | `VARCHAR(3)` | `NOT NULL` | Flag country state registration |
| `vessel_type` | **Vessel Type** | `VARCHAR(30)` | `NOT NULL` | CONTAINER, BULK, TANKER, RO-RO |
| `build_year` | **Build Year** | `INT` | `NOT NULL` | Year ship was launched |
| `deadweight_tonnage` | **Deadweight Tonnage** | `INT` | `NOT NULL` | DWT cargo capacity metric tons |
| `teu_capacity` | **Teu Capacity** | `INT` | `NOT NULL` | Twenty-foot equivalent unit limit |
| `engine_power_kw` | **Engine Power Kw** | `INT` | `NOT NULL` | Main engine power kilowatts |
| `max_speed_knots` | **Max Speed Knots** | `DECIMAL(4,1)` | `NOT NULL` | Maximum nautical speed knots |
| `owner_company` | **Owner Company** | `VARCHAR(80)` | `NOT NULL` | Vessel owner shipping corporation |
| `operator_company` | **Operator Company** | `VARCHAR(80)` | `NOT NULL` | Vessel operating charter company |
| `call_sign` | **Call Sign** | `VARCHAR(10)` | `NOT NULL` | Radio station call sign |
| `mmsi_number` | **Mmsi Number** | `VARCHAR(15)` | `NOT NULL` | Maritime Mobile Service Identity |
| `last_drydock_date` | **Last Drydock Date** | `DATE` | `NOT NULL` | Last drydock maintenance date |
| `safety_certificate_expiry` | **Safety Certificate Expiry** | `DATE` | `NOT NULL` | SOLAS safety certificate expiry |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status` | **Status** | `VARCHAR(20)` | `NOT NULL` | IN_SERVICE, DRYDOCK, CHARTERED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Vessel operational inspection notes |

---

---

### Table: `tbl_customs_declarations`
**Description**: Domain table for `tbl_customs_declarations` in `Global_Logistics_Shipping_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `declaration_id` | **Declaration Id** | `INT` | `PRIMARY KEY` | Customs declaration primary key ID |
| `shipment_id` | **Shipment Id** | `INT` | `FOREIGN KEY` | FK to tbl_freight_shipments |
| `declaration_number` | **Declaration Number** | `VARCHAR(25)` | `NOT NULL` | Customs entry declaration number |
| `customs_office_code` | **Customs Office Code** | `VARCHAR(10)` | `NOT NULL` | Customs office port code |
| `entry_date` | **Entry Date** | `DATE` | `NOT NULL` | Customs declaration entry date |
| `importer_record_id` | **Importer Record Id** | `INT` | `NOT NULL` | Importer tax ID record |
| `exporter_record_id` | **Exporter Record Id** | `INT` | `NOT NULL` | Exporter tax ID record |
| `hs_tariff_code` | **Hs Tariff Code** | `VARCHAR(12)` | `NOT NULL` | Harmonized System tariff code |
| `duty_amount_usd` | **Duty Amount Usd** | `DECIMAL(10,2)` | `NOT NULL` | Assessed customs duty USD |
| `tax_amount_usd` | **Tax Amount Usd** | `DECIMAL(10,2)` | `NOT NULL` | Assessed import VAT/tax USD |
| `inspection_status` | **Inspection Status** | `VARCHAR(30)` | `NOT NULL` | PASSED, PHYSICAL_EXAM, DOCUMENT_CHECK |
| `clearance_date` | **Clearance Date** | `DATE` | `NOT NULL` | Customs release clearance date |
| `country_of_origin` | **Country Of Origin** | `VARCHAR(3)` | `NOT NULL` | ISO-3 country of origin code |
| `country_of_destination` | **Country Of Destination** | `VARCHAR(3)` | `NOT NULL` | ISO-3 destination country code |
| `exemption_code` | **Exemption Code** | `VARCHAR(15)` | `NOT NULL` | Duty exemption code or NONE |
| `customs_broker_id` | **Customs Broker Id** | `INT` | `NOT NULL` | Broker license ID |
| `risk_score` | **Risk Score** | `INT` | `NOT NULL` | Customs automated risk score 1-100 |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | RELEASED, HELD, REJECTED |

---

---

### Table: `tbl_freight_shipments`
**Description**: Domain table for `tbl_freight_shipments` in `Global_Logistics_Shipping_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_id` | **Shipment Id** | `INT` | `PRIMARY KEY` | Freight shipment primary key ID |
| `tracking_number` | **Tracking Number** | `VARCHAR(25)` | `NOT NULL` | Global tracking waybill number |
| `shipper_id` | **Shipper Id** | `INT` | `NOT NULL` | Shipper company record ID |
| `consignee_id` | **Consignee Id** | `INT` | `NOT NULL` | Consignee recipient ID |
| `origin_port_code` | **Origin Port Code** | `VARCHAR(10)` | `NOT NULL` | Origin port UN/LOCODE |
| `destination_port_code` | **Destination Port Code** | `VARCHAR(10)` | `NOT NULL` | Destination port UN/LOCODE |
| `carrier_id` | **Carrier Id** | `INT` | `FOREIGN KEY` | FK to tbl_carrier_vessels |
| `vessel_name` | **Vessel Name** | `VARCHAR(60)` | `NOT NULL` | Container ship vessel name |
| `voyage_number` | **Voyage Number** | `VARCHAR(15)` | `NOT NULL` | Voyage manifest code |
| `container_number` | **Container Number** | `VARCHAR(20)` | `NOT NULL` | Standard 40ft container code |
| `declared_value_usd` | **Declared Value Usd** | `DECIMAL(12,2)` | `NOT NULL` | Declared customs cargo value |
| `freight_cost_usd` | **Freight Cost Usd** | `DECIMAL(10,2)` | `NOT NULL` | Freight shipping charge USD |
| `gross_weight_kg` | **Gross Weight Kg** | `DECIMAL(10,2)` | `NOT NULL` | Gross shipment weight kg |
| `net_weight_kg` | **Net Weight Kg** | `DECIMAL(10,2)` | `NOT NULL` | Net cargo weight kg |
| `volume_cubic_meters` | **Volume Cubic Meters** | `DECIMAL(8,2)` | `NOT NULL` | Cargo volume CBM |
| `shipment_status` | **Shipment Status** | `VARCHAR(30)` | `NOT NULL` | BOOKED, IN_TRANSIT, CUSTOMS, DELIVERED |
| `departure_date` | **Departure Date** | `DATE` | `NOT NULL` | Port departure date |
| `estimated_arrival_date` | **Estimated Arrival Date** | `DATE` | `NOT NULL` | Estimated arrival date |
| `actual_arrival_date` | **Actual Arrival Date** | `DATE` | `NOT NULL` | Actual arrival date |
| `customs_clearance_flag` | **Customs Clearance Flag** | `BOOLEAN` | `NOT NULL` | Customs cleared indicator |
| `hazardous_material_flag` | **Hazardous Material Flag** | `BOOLEAN` | `NOT NULL` | Hazmat cargo classification flag |
| `temperature_control_c` | **Temperature Control C** | `DECIMAL(4,1)` | `NOT NULL` | Reefer temperature setting C |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |

---

---

### Table: `tbl_port_terminals`
**Description**: Domain table for `tbl_port_terminals` in `Global_Logistics_Shipping_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `port_id` | **Port Id** | `INT` | `PRIMARY KEY` | Port primary key ID |
| `port_code` | **Port Code** | `VARCHAR(10)` | `NOT NULL` | UN/LOCODE port identifier |
| `port_name` | **Port Name** | `VARCHAR(80)` | `NOT NULL` | Official sea port terminal name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | Country code ISO-3 |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | Port city location |
| `latitude` | **Latitude** | `DECIMAL(8,4)` | `NOT NULL` | Port GPS latitude coordinate |
| `longitude` | **Longitude** | `DECIMAL(8,4)` | `NOT NULL` | Port GPS longitude coordinate |
| `berth_capacity` | **Berth Capacity** | `INT` | `NOT NULL` | Total vessel berth capacity |
| `annual_teu_capacity` | **Annual Teu Capacity** | `INT` | `NOT NULL` | Annual TEU handling capacity |
| `terminal_operator` | **Terminal Operator** | `VARCHAR(80)` | `NOT NULL` | Terminal operating company |
| `depth_meters` | **Depth Meters** | `DECIMAL(4,1)` | `NOT NULL` | Water depth draft in meters |
| `is_deepwater_port` | **Is Deepwater Port** | `BOOLEAN` | `NOT NULL` | Deepwater port flag |
| `customs_office_present` | **Customs Office Present** | `BOOLEAN` | `NOT NULL` | On-site customs office flag |
| `contact_phone` | **Contact Phone** | `VARCHAR(20)` | `NOT NULL` | Port authority telephone |
| `contact_email` | **Contact Email** | `VARCHAR(100)` | `NOT NULL` | Port operations email |
| `operating_hours` | **Operating Hours** | `VARCHAR(30)` | `NOT NULL` | 24/7 or scheduled hours |
| `security_level_code` | **Security Level Code** | `VARCHAR(15)` | `NOT NULL` | ISPS Code Security Level |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `active_flag` | **Active Flag** | `BOOLEAN` | `NOT NULL` | Active operational status |

---

---

### Table: `tbl_customers_food_food`
**Description**: Domain table for `tbl_customers_food` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_id` | **Customer Id** | `INT` | `PRIMARY KEY` | Customer primary key ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Customer name |
| `phone` | **Phone** | `VARCHAR(20)` | `NOT NULL` | Phone number |

---

---

### Table: `tbl_delivery_orders`
**Description**: Domain table for `tbl_delivery_orders` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_id` | **Order Id** | `INT` | `PRIMARY KEY` | Order primary key ID |
| `restaurant_id` | **Restaurant Id** | `INT` | `FOREIGN KEY` | FK to tbl_restaurants |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `rider_id` | **Rider Id** | `INT` | `FOREIGN KEY` | FK to tbl_riders |
| `total_amount` | **Total Amount** | `DECIMAL(10,2)` | `NOT NULL` | Order total USD |
| `order_time` | **Order Time** | `TIMESTAMP` | `NOT NULL` | Placement timestamp |

---

---

### Table: `tbl_delivery_tracking`
**Description**: Domain table for `tbl_delivery_tracking` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tracking_id` | **Tracking Id** | `INT` | `PRIMARY KEY` | Tracking primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_delivery_orders |
| `pickup_time` | **Pickup Time** | `TIMESTAMP` | `NULL` | Restaurant pickup time |
| `delivered_time` | **Delivered Time** | `TIMESTAMP` | `NULL` | Customer dropoff time |

---

---

### Table: `tbl_menu_items`
**Description**: Domain table for `tbl_menu_items` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `menu_item_id` | **Menu Item Id** | `INT` | `PRIMARY KEY` | Menu item primary key ID |
| `restaurant_id` | **Restaurant Id** | `INT` | `FOREIGN KEY` | FK to tbl_restaurants |
| `dish_name` | **Dish Name** | `VARCHAR(100)` | `NOT NULL` | Dish title |
| `price` | **Price** | `DECIMAL(8,2)` | `NOT NULL` | Price USD |

---

---

### Table: `tbl_order_line_items`
**Description**: Domain table for `tbl_order_line_items` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `line_item_id` | **Line Item Id** | `INT` | `PRIMARY KEY` | Line item primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_delivery_orders |
| `menu_item_id` | **Menu Item Id** | `INT` | `FOREIGN KEY` | FK to tbl_menu_items |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Portion quantity |

---

---

### Table: `tbl_restaurants`
**Description**: Domain table for `tbl_restaurants` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `restaurant_id` | **Restaurant Id** | `INT` | `PRIMARY KEY` | Restaurant primary key ID |
| `restaurant_name` | **Restaurant Name** | `VARCHAR(100)` | `NOT NULL` | Business name |
| `cuisine_type` | **Cuisine Type** | `VARCHAR(40)` | `NOT NULL` | Cuisine category (ITALIAN/MEXICAN) |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City |

---

---

### Table: `tbl_riders`
**Description**: Domain table for `tbl_riders` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `rider_id` | **Rider Id** | `INT` | `PRIMARY KEY` | Rider primary key ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Rider name |
| `vehicle_type` | **Vehicle Type** | `VARCHAR(20)` | `NOT NULL` | BICYCLE/SCOOTER/CAR |
| `rating` | **Rating** | `DECIMAL(3,2)` | `NOT NULL` | Rider rating 1-5 |

---

---

### Table: `src_doctor_physicians`
**Description**: Domain table for `src_doctor_physicians` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `physician_id` | **Physician Id** | `INT` | `PRIMARY KEY` | Physician primary key ID |
| `npi_number` | **Npi Number** | `VARCHAR(10)` | `NOT NULL` | National Provider Identifier NPI |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Physician first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Physician last name |
| `specialty` | **Specialty** | `VARCHAR(60)` | `NOT NULL` | Medical specialty field |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `phone_contact` | **Phone Contact** | `VARCHAR(20)` | `NOT NULL` | Direct telephone contact |

---

---

### Table: `src_ehr_audit_logs`
**Description**: Domain table for `src_ehr_audit_logs` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `log_id` | **Log Id** | `INT` | `PRIMARY KEY` | Audit log primary key ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Clinician user ID |
| `action_type` | **Action Type** | `VARCHAR(30)` | `NOT NULL` | READ/WRITE/DELETE |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `ip_address` | **Ip Address** | `VARCHAR(45)` | `NOT NULL` | Workstation IP |
| `log_timestamp` | **Log Timestamp** | `TIMESTAMP` | `NOT NULL` | Audit timestamp |

---

---

### Table: `src_emergency_contacts`
**Description**: Domain table for `src_emergency_contacts` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `contact_id` | **Contact Id** | `INT` | `PRIMARY KEY` | Emergency contact primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `contact_name` | **Contact Name** | `VARCHAR(60)` | `NOT NULL` | Contact person full name |
| `relationship` | **Relationship** | `VARCHAR(30)` | `NOT NULL` | SPOUSE/PARENT/SIBLING |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NOT NULL` | Emergency phone number |

---

---

### Table: `src_hospital_departments`
**Description**: Domain table for `src_hospital_departments` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `department_id` | **Department Id** | `INT` | `PRIMARY KEY` | Department primary key ID |
| `dept_name` | **Dept Name** | `VARCHAR(60)` | `NOT NULL` | Clinical department designation |
| `facility_name` | **Facility Name** | `VARCHAR(80)` | `NOT NULL` | Hospital facility complex |
| `building_location` | **Building Location** | `VARCHAR(40)` | `NOT NULL` | Building or floor wing |
| `phone_extension` | **Phone Extension** | `VARCHAR(10)` | `NOT NULL` | Internal phone extension |

---

---

### Table: `src_hospital_encounters`
**Description**: Domain table for `src_hospital_encounters` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `encounter_id` | **Encounter Id** | `INT` | `PRIMARY KEY` | Encounter primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `attending_physician_id` | **Attending Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `encounter_class` | **Encounter Class** | `VARCHAR(20)` | `NOT NULL` | INPATIENT/OUTPATIENT/EMERGENCY |
| `admission_date` | **Admission Date** | `TIMESTAMP` | `NOT NULL` | Admission timestamp |
| `discharge_date` | **Discharge Date** | `TIMESTAMP` | `NULL` | Discharge timestamp |
| `encounter_status` | **Encounter Status** | `VARCHAR(15)` | `NOT NULL` | ACTIVE/FINISHED/CANCELLED |

---

---

### Table: `src_hospital_staff_roster`
**Description**: Domain table for `src_hospital_staff_roster` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `staff_id` | **Staff Id** | `INT` | `PRIMARY KEY` | Staff primary key ID |
| `employee_number` | **Employee Number** | `VARCHAR(20)` | `NOT NULL` | Staff badge ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Staff full name |
| `role_title` | **Role Title** | `VARCHAR(50)` | `NOT NULL` | NURSE/TECHNICIAN/ADMIN |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `phone_extension` | **Phone Extension** | `VARCHAR(10)` | `NOT NULL` | Internal phone extension |

---

---

### Table: `src_insurance_claims`
**Description**: Domain table for `src_insurance_claims` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `claim_id` | **Claim Id** | `INT` | `PRIMARY KEY` | Insurance claim primary key ID |
| `billing_id` | **Billing Id** | `INT` | `FOREIGN KEY` | FK to src_patient_billing |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `payer_name` | **Payer Name** | `VARCHAR(80)` | `NOT NULL` | Health insurance provider |
| `claim_amount` | **Claim Amount** | `DECIMAL(10,2)` | `NOT NULL` | Claimed reimbursement amount |
| `covered_amount` | **Covered Amount** | `DECIMAL(10,2)` | `NOT NULL` | Approved covered amount |
| `claim_status` | **Claim Status** | `VARCHAR(15)` | `NOT NULL` | SUBMITTED/PAID/DENIED |
| `submission_date` | **Submission Date** | `DATE` | `NOT NULL` | Payer filing date |

---

---

### Table: `src_lab_results`
**Description**: Domain table for `src_lab_results` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lab_result_id` | **Lab Result Id** | `INT` | `PRIMARY KEY` | Lab result primary key ID |
| `lab_order_id` | **Lab Order Id** | `INT` | `FOREIGN KEY` | FK to src_lab_test_orders |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `result_value` | **Result Value** | `DECIMAL(10,2)` | `NOT NULL` | Quantitative lab measurement |
| `unit_of_measure` | **Unit Of Measure** | `VARCHAR(20)` | `NOT NULL` | Measurement unit (mg/dL) |
| `reference_range` | **Reference Range** | `VARCHAR(30)` | `NOT NULL` | Normal reference range |
| `result_status` | **Result Status** | `VARCHAR(15)` | `NOT NULL` | FINAL/PRELIMINARY |
| `result_date` | **Result Date** | `TIMESTAMP` | `NOT NULL` | Result timestamp |

---

---

### Table: `src_lab_test_orders`
**Description**: Domain table for `src_lab_test_orders` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lab_order_id` | **Lab Order Id** | `INT` | `PRIMARY KEY` | Lab order primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `ordering_physician_id` | **Ordering Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `loinc_code` | **Loinc Code** | `VARCHAR(20)` | `NOT NULL` | LOINC lab test concept code |
| `test_name` | **Test Name** | `VARCHAR(100)` | `NOT NULL` | Lab panel test title |
| `order_date` | **Order Date** | `TIMESTAMP` | `NOT NULL` | Order timestamp |
| `order_status` | **Order Status** | `VARCHAR(15)` | `NOT NULL` | ORDERED/COMPLETED/CANCELLED |

---

---

### Table: `src_medical_diagnoses`
**Description**: Domain table for `src_medical_diagnoses` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `diagnosis_id` | **Diagnosis Id** | `INT` | `PRIMARY KEY` | Diagnosis primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `icd10_code` | **Icd10 Code** | `VARCHAR(20)` | `NOT NULL` | ICD-10 clinical diagnosis code |
| `diagnosis_name` | **Diagnosis Name** | `VARCHAR(100)` | `NOT NULL` | Diagnosis description |
| `diagnosis_date` | **Diagnosis Date** | `DATE` | `NOT NULL` | Onset or diagnosis date |

---

---

### Table: `src_medical_history`
**Description**: Domain table for `src_medical_history` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `history_id` | **History Id** | `INT` | `PRIMARY KEY` | Medical history primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `condition_name` | **Condition Name** | `VARCHAR(100)` | `NOT NULL` | Pre-existing medical condition |
| `onset_date` | **Onset Date** | `DATE` | `NOT NULL` | Condition onset date |
| `condition_status` | **Condition Status** | `VARCHAR(15)` | `NOT NULL` | ACTIVE/RESOLVED |

---

---

### Table: `src_medical_prescriptions`
**Description**: Domain table for `src_medical_prescriptions` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `prescription_id` | **Prescription Id** | `INT` | `PRIMARY KEY` | Prescription primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `prescribing_physician_id` | **Prescribing Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `rxnorm_code` | **Rxnorm Code** | `VARCHAR(20)` | `NOT NULL` | RxNorm medication code |
| `medication_name` | **Medication Name** | `VARCHAR(100)` | `NOT NULL` | Medication trade name |
| `dosage_instructions` | **Dosage Instructions** | `VARCHAR(100)` | `NOT NULL` | Dosage and frequency |
| `prescribed_date` | **Prescribed Date** | `DATE` | `NOT NULL` | Prescription order date |

---

---

### Table: `src_patient_appointments`
**Description**: Domain table for `src_patient_appointments` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `appointment_id` | **Appointment Id** | `INT` | `PRIMARY KEY` | Appointment primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `physician_id` | **Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `appointment_time` | **Appointment Time** | `TIMESTAMP` | `NOT NULL` | Scheduled appointment timestamp |
| `appointment_status` | **Appointment Status** | `VARCHAR(15)` | `NOT NULL` | SCHEDULED/COMPLETED/NO_SHOW |

---

---

### Table: `src_patient_billing`
**Description**: Domain table for `src_patient_billing` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `billing_id` | **Billing Id** | `INT` | `PRIMARY KEY` | Patient billing primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `total_charge_amount` | **Total Charge Amount** | `DECIMAL(10,2)` | `NOT NULL` | Gross medical charge |
| `paid_amount` | **Paid Amount** | `DECIMAL(10,2)` | `NOT NULL` | Settled payment amount |
| `balance_due` | **Balance Due** | `DECIMAL(10,2)` | `NOT NULL` | Outstanding invoice balance |
| `billing_date` | **Billing Date** | `DATE` | `NOT NULL` | Statement generation date |
| `billing_status` | **Billing Status** | `VARCHAR(15)` | `NOT NULL` | BILLED/PAID/OVERDUE |

---

---

### Table: `src_patient_immunizations`
**Description**: Domain table for `src_patient_immunizations` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `immunization_id` | **Immunization Id** | `INT` | `PRIMARY KEY` | Immunization primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `vaccine_code` | **Vaccine Code** | `VARCHAR(20)` | `NOT NULL` | CVX vaccine code |
| `vaccine_name` | **Vaccine Name** | `VARCHAR(100)` | `NOT NULL` | Vaccine trade name |
| `administered_date` | **Administered Date** | `DATE` | `NOT NULL` | Vaccination date |
| `dose_number` | **Dose Number** | `INT` | `NOT NULL` | Dose sequence number |

---

---

### Table: `src_patient_master`
**Description**: Domain table for `src_patient_master` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `patient_id` | **Patient Id** | `INT` | `PRIMARY KEY` | Patient primary key ID |
| `mrn_number` | **Mrn Number** | `VARCHAR(30)` | `NOT NULL` | Medical Record Number MRN |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Patient given first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Patient family last name |
| `gender_code` | **Gender Code** | `VARCHAR(1)` | `NOT NULL` | Administrative gender (M/F/U) |
| `date_of_birth` | **Date Of Birth** | `DATE` | `NOT NULL` | Patient birth date |
| `phone_contact` | **Phone Contact** | `VARCHAR(20)` | `NOT NULL` | Primary telephone contact |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City location |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/Province code |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | EHR entry timestamp |

---

---

### Table: `src_patient_vitals_signs`
**Description**: Domain table for `src_patient_vitals_signs` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vital_id` | **Vital Id** | `INT` | `PRIMARY KEY` | Vital sign primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `vital_type` | **Vital Type** | `VARCHAR(30)` | `NOT NULL` | HEART_RATE/BP_SYSTOLIC/TEMP |
| `numeric_value` | **Numeric Value** | `DECIMAL(8,2)` | `NOT NULL` | Measurement reading |
| `unit_of_measure` | **Unit Of Measure** | `VARCHAR(20)` | `NOT NULL` | Measurement unit |
| `recorded_time` | **Recorded Time** | `TIMESTAMP` | `NOT NULL` | Observation timestamp |

---