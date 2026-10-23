-- ========================================================
-- Master DDL Schema Script for Dataset_05_Hospitality_Mobility_Aviation_Fleet_20x30_source
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 20
-- Domains Included: Dataset_05_Airline_Reservation_Dataset, Dataset_19_Hotel_Hospitality_Dataset, Dataset_24_Ride_Sharing_Transit_Dataset
-- ========================================================

CREATE TABLE tbl_aircraft_fleet (
    aircraft_id                    INT             PRIMARY KEY                                                , -- Aircraft primary key ID
    tail_number                    VARCHAR(10)     NOT NULL                                                   , -- Tail registration
    model_name                     VARCHAR(40)     NOT NULL                                                   , -- Boeing 737 / Airbus A320
    passenger_seats                INT             NOT NULL                                                     -- Total seat capacity
);

CREATE TABLE tbl_airports (
    airport_id                     INT             PRIMARY KEY                                                , -- Airport primary key ID
    iata_code                      VARCHAR(3)      NOT NULL                                                   , -- JFK/LAX/LHR
    airport_name                   VARCHAR(100)    NOT NULL                                                   , -- Airport name
    city                           VARCHAR(50)     NOT NULL                                                     -- City
);

CREATE TABLE tbl_baggage_claims (
    bag_id                         INT             PRIMARY KEY                                                , -- Baggage primary key ID
    booking_id                     INT             NOT NULL REFERENCES tbl_flight_bookings(booking_id)        , -- FK to tbl_flight_bookings
    weight_kg                      DECIMAL(4,1)    NOT NULL                                                     -- Bag weight kg
);

CREATE TABLE tbl_flight_bookings (
    booking_id                     INT             PRIMARY KEY                                                , -- Booking primary key ID
    flight_id                      INT             NOT NULL REFERENCES tbl_scheduled_flights(flight_id)       , -- FK to tbl_scheduled_flights
    passenger_id                   INT             NOT NULL REFERENCES tbl_passengers(passenger_id)           , -- FK to tbl_passengers
    ticket_price                   DECIMAL(8,2)    NOT NULL                                                   , -- Fare price USD
    seat_number                    VARCHAR(5)      NOT NULL                                                     -- Seat assignment (12A)
);

CREATE TABLE tbl_passengers (
    passenger_id                   INT             PRIMARY KEY                                                , -- Passenger primary key ID
    passport_number                VARCHAR(20)     NOT NULL                                                   , -- Passport ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE tbl_scheduled_flights (
    flight_id                      INT             PRIMARY KEY                                                , -- Flight primary key ID
    flight_number                  VARCHAR(10)     NOT NULL                                                   , -- Flight code AA100
    origin_airport_id              INT             NOT NULL REFERENCES tbl_airports(airport_id)               , -- FK to tbl_airports
    dest_airport_id                INT             NOT NULL REFERENCES tbl_airports(airport_id)               , -- FK to tbl_airports
    aircraft_id                    INT             NOT NULL REFERENCES tbl_aircraft_fleet(aircraft_id)        , -- FK to tbl_aircraft_fleet
    scheduled_departure            TIMESTAMP       NOT NULL                                                     -- Departure time
);

CREATE TABLE tbl_guest_feedback (
    feedback_id                    INT             PRIMARY KEY                                                , -- Feedback primary key ID
    reservation_id                 INT             NOT NULL REFERENCES tbl_reservations(reservation_id)       , -- FK to tbl_reservations
    cleanliness_score              INT             NOT NULL                                                   , -- Score 1-10
    staff_score                    INT             NOT NULL                                                     -- Score 1-10
);

CREATE TABLE tbl_guests (
    guest_id                       INT             PRIMARY KEY                                                , -- Guest primary key ID
    passport_number                VARCHAR(20)     NOT NULL                                                   , -- Passport or ID number
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- First name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Last name
    country_code                   VARCHAR(3)      NOT NULL                                                     -- Country code
);

CREATE TABLE tbl_hotels (
    hotel_id                       INT             PRIMARY KEY                                                , -- Hotel primary key ID
    hotel_code                     VARCHAR(15)     NOT NULL                                                   , -- Resort or hotel chain code
    hotel_name                     VARCHAR(80)     NOT NULL                                                   , -- Hotel property name
    city                           VARCHAR(50)     NOT NULL                                                   , -- City location
    star_rating                    INT             NOT NULL                                                     -- Star classification 1-5
);

CREATE TABLE tbl_reservations (
    reservation_id                 INT             PRIMARY KEY                                                , -- Reservation primary key ID
    room_id                        INT             NOT NULL REFERENCES tbl_rooms(room_id)                     , -- FK to tbl_rooms
    guest_id                       INT             NOT NULL REFERENCES tbl_guests(guest_id)                   , -- FK to tbl_guests
    check_in_date                  DATE            NOT NULL                                                   , -- Arrival date
    check_out_date                 DATE            NOT NULL                                                   , -- Departure date
    booking_status                 VARCHAR(20)     NOT NULL                                                     -- CONFIRMED/CHECKED_IN/CHECKED_OUT/CANCELLED
);

CREATE TABLE tbl_room_charges (
    charge_id                      INT             PRIMARY KEY                                                , -- Charge primary key ID
    reservation_id                 INT             NOT NULL REFERENCES tbl_reservations(reservation_id)       , -- FK to tbl_reservations
    charge_type                    VARCHAR(30)     NOT NULL                                                   , -- ROOM/ROOM_SERVICE/MINIBAR/SPA
    amount                         DECIMAL(8,2)    NOT NULL                                                     -- Billed amount
);

CREATE TABLE tbl_room_types (
    type_id                        INT             PRIMARY KEY                                                , -- Type primary key ID
    type_name                      VARCHAR(40)     NOT NULL                                                   , -- SINGLE/DOUBLE/SUITE/PRESIDENTIAL
    base_nightly_rate              DECIMAL(8,2)    NOT NULL                                                     -- Base price per night
);

CREATE TABLE tbl_rooms (
    room_id                        INT             PRIMARY KEY                                                , -- Room primary key ID
    hotel_id                       INT             NOT NULL REFERENCES tbl_hotels(hotel_id)                   , -- FK to tbl_hotels
    type_id                        INT             NOT NULL REFERENCES tbl_room_types(type_id)                , -- FK to tbl_room_types
    room_number                    VARCHAR(10)     NOT NULL                                                   , -- Room door number
    floor_number                   INT             NOT NULL                                                     -- Building floor level
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

CREATE TABLE tbl_passengers_ride (
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
