# Business Data Glossary - Dataset_05_Hospitality_Mobility_Aviation_Fleet_20x30_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_05_Hospitality_Mobility_Aviation_Fleet_20x30_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_05_Hospitality_Mobility_Aviation_Fleet_20x30
- **Component**: Source Database Schema (Dataset_05_Hospitality_Mobility_Aviation_Fleet_20x30_source)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Source Tables**: 20
- **Theme Focus**: Global Hospitality, Airline Reservations, Fleet Mobility & Ride Transit
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `tbl_aircraft_fleet`
**Description**: Domain table for `tbl_aircraft_fleet` in `Airline_Reservation_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `aircraft_id` | **Aircraft Id** | `INT` | `PRIMARY KEY` | Aircraft primary key ID |
| `tail_number` | **Tail Number** | `VARCHAR(10)` | `NOT NULL` | Tail registration |
| `model_name` | **Model Name** | `VARCHAR(40)` | `NOT NULL` | Boeing 737 / Airbus A320 |
| `passenger_seats` | **Passenger Seats** | `INT` | `NOT NULL` | Total seat capacity |

---

---

### Table: `tbl_airports`
**Description**: Domain table for `tbl_airports` in `Airline_Reservation_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `airport_id` | **Airport Id** | `INT` | `PRIMARY KEY` | Airport primary key ID |
| `iata_code` | **Iata Code** | `VARCHAR(3)` | `NOT NULL` | JFK/LAX/LHR |
| `airport_name` | **Airport Name** | `VARCHAR(100)` | `NOT NULL` | Airport name |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City |

---

---

### Table: `tbl_baggage_claims`
**Description**: Domain table for `tbl_baggage_claims` in `Airline_Reservation_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `bag_id` | **Bag Id** | `INT` | `PRIMARY KEY` | Baggage primary key ID |
| `booking_id` | **Booking Id** | `INT` | `FOREIGN KEY` | FK to tbl_flight_bookings |
| `weight_kg` | **Weight Kg** | `DECIMAL(4,1)` | `NOT NULL` | Bag weight kg |

---

---

### Table: `tbl_flight_bookings`
**Description**: Domain table for `tbl_flight_bookings` in `Airline_Reservation_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `booking_id` | **Booking Id** | `INT` | `PRIMARY KEY` | Booking primary key ID |
| `flight_id` | **Flight Id** | `INT` | `FOREIGN KEY` | FK to tbl_scheduled_flights |
| `passenger_id` | **Passenger Id** | `INT` | `FOREIGN KEY` | FK to tbl_passengers |
| `ticket_price` | **Ticket Price** | `DECIMAL(8,2)` | `NOT NULL` | Fare price USD |
| `seat_number` | **Seat Number** | `VARCHAR(5)` | `NOT NULL` | Seat assignment (12A) |

---

---

### Table: `tbl_passengers`
**Description**: Domain table for `tbl_passengers` in `Airline_Reservation_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `passenger_id` | **Passenger Id** | `INT` | `PRIMARY KEY` | Passenger primary key ID |
| `passport_number` | **Passport Number** | `VARCHAR(20)` | `NOT NULL` | Passport ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `tbl_scheduled_flights`
**Description**: Domain table for `tbl_scheduled_flights` in `Airline_Reservation_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `flight_id` | **Flight Id** | `INT` | `PRIMARY KEY` | Flight primary key ID |
| `flight_number` | **Flight Number** | `VARCHAR(10)` | `NOT NULL` | Flight code AA100 |
| `origin_airport_id` | **Origin Airport Id** | `INT` | `FOREIGN KEY` | FK to tbl_airports |
| `dest_airport_id` | **Dest Airport Id** | `INT` | `FOREIGN KEY` | FK to tbl_airports |
| `aircraft_id` | **Aircraft Id** | `INT` | `FOREIGN KEY` | FK to tbl_aircraft_fleet |
| `scheduled_departure` | **Scheduled Departure** | `TIMESTAMP` | `NOT NULL` | Departure time |

---

---

### Table: `tbl_guest_feedback`
**Description**: Domain table for `tbl_guest_feedback` in `Hotel_Hospitality_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `feedback_id` | **Feedback Id** | `INT` | `PRIMARY KEY` | Feedback primary key ID |
| `reservation_id` | **Reservation Id** | `INT` | `FOREIGN KEY` | FK to tbl_reservations |
| `cleanliness_score` | **Cleanliness Score** | `INT` | `NOT NULL` | Score 1-10 |
| `staff_score` | **Staff Score** | `INT` | `NOT NULL` | Score 1-10 |

---

---

### Table: `tbl_guests`
**Description**: Domain table for `tbl_guests` in `Hotel_Hospitality_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `guest_id` | **Guest Id** | `INT` | `PRIMARY KEY` | Guest primary key ID |
| `passport_number` | **Passport Number** | `VARCHAR(20)` | `NOT NULL` | Passport or ID number |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | First name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Last name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | Country code |

---

---

### Table: `tbl_hotels`
**Description**: Domain table for `tbl_hotels` in `Hotel_Hospitality_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `hotel_id` | **Hotel Id** | `INT` | `PRIMARY KEY` | Hotel primary key ID |
| `hotel_code` | **Hotel Code** | `VARCHAR(15)` | `NOT NULL` | Resort or hotel chain code |
| `hotel_name` | **Hotel Name** | `VARCHAR(80)` | `NOT NULL` | Hotel property name |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City location |
| `star_rating` | **Star Rating** | `INT` | `NOT NULL` | Star classification 1-5 |

---

---

### Table: `tbl_reservations`
**Description**: Domain table for `tbl_reservations` in `Hotel_Hospitality_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `reservation_id` | **Reservation Id** | `INT` | `PRIMARY KEY` | Reservation primary key ID |
| `room_id` | **Room Id** | `INT` | `FOREIGN KEY` | FK to tbl_rooms |
| `guest_id` | **Guest Id** | `INT` | `FOREIGN KEY` | FK to tbl_guests |
| `check_in_date` | **Check In Date** | `DATE` | `NOT NULL` | Arrival date |
| `check_out_date` | **Check Out Date** | `DATE` | `NOT NULL` | Departure date |
| `booking_status` | **Booking Status** | `VARCHAR(20)` | `NOT NULL` | CONFIRMED/CHECKED_IN/CHECKED_OUT/CANCELLED |

---

---

### Table: `tbl_room_charges`
**Description**: Domain table for `tbl_room_charges` in `Hotel_Hospitality_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `charge_id` | **Charge Id** | `INT` | `PRIMARY KEY` | Charge primary key ID |
| `reservation_id` | **Reservation Id** | `INT` | `FOREIGN KEY` | FK to tbl_reservations |
| `charge_type` | **Charge Type** | `VARCHAR(30)` | `NOT NULL` | ROOM/ROOM_SERVICE/MINIBAR/SPA |
| `amount` | **Amount** | `DECIMAL(8,2)` | `NOT NULL` | Billed amount |

---

---

### Table: `tbl_room_types`
**Description**: Domain table for `tbl_room_types` in `Hotel_Hospitality_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `type_id` | **Type Id** | `INT` | `PRIMARY KEY` | Type primary key ID |
| `type_name` | **Type Name** | `VARCHAR(40)` | `NOT NULL` | SINGLE/DOUBLE/SUITE/PRESIDENTIAL |
| `base_nightly_rate` | **Base Nightly Rate** | `DECIMAL(8,2)` | `NOT NULL` | Base price per night |

---

---

### Table: `tbl_rooms`
**Description**: Domain table for `tbl_rooms` in `Hotel_Hospitality_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `room_id` | **Room Id** | `INT` | `PRIMARY KEY` | Room primary key ID |
| `hotel_id` | **Hotel Id** | `INT` | `FOREIGN KEY` | FK to tbl_hotels |
| `type_id` | **Type Id** | `INT` | `FOREIGN KEY` | FK to tbl_room_types |
| `room_number` | **Room Number** | `VARCHAR(10)` | `NOT NULL` | Room door number |
| `floor_number` | **Floor Number** | `INT` | `NOT NULL` | Building floor level |

---

---

### Table: `tbl_driver_payouts`
**Description**: Domain table for `tbl_driver_payouts` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payout_id` | **Payout Id** | `INT` | `PRIMARY KEY` | Payout primary key ID |
| `driver_id` | **Driver Id** | `INT` | `FOREIGN KEY` | FK to tbl_drivers |
| `payout_amount` | **Payout Amount** | `DECIMAL(10,2)` | `NOT NULL` | Weekly earnings payout |

---

---

### Table: `tbl_driver_vehicles`
**Description**: Domain table for `tbl_driver_vehicles` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vehicle_id` | **Vehicle Id** | `INT` | `PRIMARY KEY` | Vehicle primary key ID |
| `driver_id` | **Driver Id** | `INT` | `FOREIGN KEY` | FK to tbl_drivers |
| `license_plate` | **License Plate** | `VARCHAR(15)` | `NOT NULL` | Plate code |
| `make_model` | **Make Model** | `VARCHAR(60)` | `NOT NULL` | Car model string |

---

---

### Table: `tbl_drivers`
**Description**: Domain table for `tbl_drivers` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `driver_id` | **Driver Id** | `INT` | `PRIMARY KEY` | Driver primary key ID |
| `license_number` | **License Number** | `VARCHAR(30)` | `NOT NULL` | Drivers license code |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Driver full name |
| `rating` | **Rating** | `DECIMAL(3,2)` | `NOT NULL` | Star rating |

---

---

### Table: `tbl_fare_payments`
**Description**: Domain table for `tbl_fare_payments` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fare_id` | **Fare Id** | `INT` | `PRIMARY KEY` | Fare primary key ID |
| `trip_id` | **Trip Id** | `INT` | `FOREIGN KEY` | FK to tbl_ride_trips |
| `base_fare` | **Base Fare** | `DECIMAL(8,2)` | `NOT NULL` | Base charge |
| `tip_amount` | **Tip Amount** | `DECIMAL(8,2)` | `NOT NULL` | Tip amount |

---

---

### Table: `tbl_passengers_ride_ride`
**Description**: Domain table for `tbl_passengers_ride` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `passenger_id` | **Passenger Id** | `INT` | `PRIMARY KEY` | Passenger primary key ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |
| `phone` | **Phone** | `VARCHAR(20)` | `NOT NULL` | Phone number |

---

---

### Table: `tbl_ride_requests`
**Description**: Domain table for `tbl_ride_requests` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `request_id` | **Request Id** | `INT` | `PRIMARY KEY` | Request primary key ID |
| `passenger_id` | **Passenger Id** | `INT` | `FOREIGN KEY` | FK to tbl_passengers |
| `pickup_city` | **Pickup City** | `VARCHAR(50)` | `NOT NULL` | City |
| `requested_time` | **Requested Time** | `TIMESTAMP` | `NOT NULL` | Request timestamp |

---

---

### Table: `tbl_ride_trips`
**Description**: Domain table for `tbl_ride_trips` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `trip_id` | **Trip Id** | `INT` | `PRIMARY KEY` | Trip primary key ID |
| `request_id` | **Request Id** | `INT` | `FOREIGN KEY` | FK to tbl_ride_requests |
| `driver_id` | **Driver Id** | `INT` | `FOREIGN KEY` | FK to tbl_drivers |
| `distance_miles` | **Distance Miles** | `DECIMAL(6,2)` | `NOT NULL` | Trip length miles |
| `duration_minutes` | **Duration Minutes** | `INT` | `NOT NULL` | Duration in minutes |

---