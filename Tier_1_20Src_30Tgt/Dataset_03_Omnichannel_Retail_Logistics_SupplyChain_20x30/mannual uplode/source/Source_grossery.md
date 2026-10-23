# Business Data Glossary - Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_20x30_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_20x30_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_20x30
- **Component**: Source Database Schema (Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_20x30_source)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Source Tables**: 20
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