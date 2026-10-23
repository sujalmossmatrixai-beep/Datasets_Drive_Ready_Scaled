# Business Data Glossary - Dataset_06_DigitalMedia_Gaming_Entertainment_Social_20x30_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_06_DigitalMedia_Gaming_Entertainment_Social_20x30_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_06_DigitalMedia_Gaming_Entertainment_Social_20x30
- **Component**: Source Database Schema (Dataset_06_DigitalMedia_Gaming_Entertainment_Social_20x30_source)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Source Tables**: 20
- **Theme Focus**: Streaming Media, Esports Gaming, Live Event Ticketing & Social Networks
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `tbl_content_creators`
**Description**: Domain table for `tbl_content_creators` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `creator_id` | **Creator Id** | `INT` | `PRIMARY KEY` | Creator primary key ID |
| `creator_name` | **Creator Name** | `VARCHAR(100)` | `NOT NULL` | Artist or Studio name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | Country ISO |

---

---

### Table: `tbl_media_catalog`
**Description**: Domain table for `tbl_media_catalog` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `media_id` | **Media Id** | `INT` | `PRIMARY KEY` | Media item primary key ID |
| `creator_id` | **Creator Id** | `INT` | `FOREIGN KEY` | FK to tbl_content_creators |
| `title` | **Title** | `VARCHAR(120)` | `NOT NULL` | Track or Movie title |
| `media_type` | **Media Type** | `VARCHAR(20)` | `NOT NULL` | AUDIO/VIDEO/PODCAST |
| `duration_seconds` | **Duration Seconds** | `INT` | `NOT NULL` | Play duration in seconds |

---

---

### Table: `tbl_playlists`
**Description**: Domain table for `tbl_playlists` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `playlist_id` | **Playlist Id** | `INT` | `PRIMARY KEY` | Playlist primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `playlist_title` | **Playlist Title** | `VARCHAR(80)` | `NOT NULL` | Title |

---

---

### Table: `tbl_stream_history`
**Description**: Domain table for `tbl_stream_history` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `stream_id` | **Stream Id** | `INT` | `PRIMARY KEY` | Stream primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `media_id` | **Media Id** | `INT` | `FOREIGN KEY` | FK to tbl_media_catalog |
| `streamed_seconds` | **Streamed Seconds** | `INT` | `NOT NULL` | Watched seconds |
| `streamed_at` | **Streamed At** | `TIMESTAMP` | `NOT NULL` | Timestamp |

---

---

### Table: `tbl_subscription_tiers`
**Description**: Domain table for `tbl_subscription_tiers` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tier_id` | **Tier Id** | `INT` | `PRIMARY KEY` | Tier primary key ID |
| `tier_name` | **Tier Name** | `VARCHAR(40)` | `NOT NULL` | FREE/PREMIUM/FAMILY |
| `monthly_price` | **Monthly Price** | `DECIMAL(8,2)` | `NOT NULL` | Price USD |
| `max_streams` | **Max Streams** | `INT` | `NOT NULL` | Simultaneous streams allowed |

---

---

### Table: `tbl_user_ratings`
**Description**: Domain table for `tbl_user_ratings` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `rating_id` | **Rating Id** | `INT` | `PRIMARY KEY` | Rating primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `media_id` | **Media Id** | `INT` | `FOREIGN KEY` | FK to tbl_media_catalog |
| `stars` | **Stars** | `INT` | `NOT NULL` | Rating 1-5 |

---

---

### Table: `tbl_user_subscriptions`
**Description**: Domain table for `tbl_user_subscriptions` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `subscription_id` | **Subscription Id** | `INT` | `PRIMARY KEY` | Subscription primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `tier_id` | **Tier Id** | `INT` | `FOREIGN KEY` | FK to tbl_subscription_tiers |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Start date |
| `auto_renew` | **Auto Renew** | `VARCHAR(1)` | `NOT NULL` | Auto-renew Y/N |

---

---

### Table: `tbl_users`
**Description**: Domain table for `tbl_users` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_id` | **User Id** | `INT` | `PRIMARY KEY` | User primary key ID |
| `username` | **Username** | `VARCHAR(50)` | `NOT NULL` | Unique handle |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Contact email |
| `registration_date` | **Registration Date** | `DATE` | `NOT NULL` | Sign up date |

---

---

### Table: `tbl_esports_teams`
**Description**: Domain table for `tbl_esports_teams` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `team_id` | **Team Id** | `INT` | `PRIMARY KEY` | Team primary key ID |
| `team_name` | **Team Name** | `VARCHAR(80)` | `NOT NULL` | Org team name |
| `region_code` | **Region Code** | `VARCHAR(10)` | `NOT NULL` | NA/EU/APAC |

---

---

### Table: `tbl_ingame_store_items`
**Description**: Domain table for `tbl_ingame_store_items` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `item_id` | **Item Id** | `INT` | `PRIMARY KEY` | Item primary key ID |
| `item_name` | **Item Name** | `VARCHAR(80)` | `NOT NULL` | Skin or Cosmetic name |
| `virtual_currency_cost` | **Virtual Currency Cost** | `INT` | `NOT NULL` | Gems or Coins cost |

---

---

### Table: `tbl_match_player_stats`
**Description**: Domain table for `tbl_match_player_stats` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `stat_id` | **Stat Id** | `INT` | `PRIMARY KEY` | Stat primary key ID |
| `match_id` | **Match Id** | `INT` | `FOREIGN KEY` | FK to tbl_matches |
| `player_id` | **Player Id** | `INT` | `FOREIGN KEY` | FK to tbl_players |
| `kills` | **Kills** | `INT` | `NOT NULL` | Eliminations |
| `deaths` | **Deaths** | `INT` | `NOT NULL` | Deaths |
| `assists` | **Assists** | `INT` | `NOT NULL` | Assists |

---

---

### Table: `tbl_matches`
**Description**: Domain table for `tbl_matches` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `match_id` | **Match Id** | `INT` | `PRIMARY KEY` | Match primary key ID |
| `tournament_id` | **Tournament Id** | `INT` | `FOREIGN KEY` | FK to tbl_tournaments |
| `winning_team_id` | **Winning Team Id** | `INT` | `FOREIGN KEY` | FK to tbl_esports_teams |
| `match_date` | **Match Date** | `TIMESTAMP` | `NOT NULL` | Match timestamp |

---

---

### Table: `tbl_player_purchases`
**Description**: Domain table for `tbl_player_purchases` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `purchase_id` | **Purchase Id** | `INT` | `PRIMARY KEY` | Purchase primary key ID |
| `player_id` | **Player Id** | `INT` | `FOREIGN KEY` | FK to tbl_players |
| `item_id` | **Item Id** | `INT` | `FOREIGN KEY` | FK to tbl_ingame_store_items |
| `purchase_date` | **Purchase Date** | `TIMESTAMP` | `NOT NULL` | Transaction timestamp |

---

---

### Table: `tbl_players`
**Description**: Domain table for `tbl_players` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `player_id` | **Player Id** | `INT` | `PRIMARY KEY` | Player primary key ID |
| `team_id` | **Team Id** | `INT` | `FOREIGN KEY` | FK to tbl_esports_teams |
| `gamer_tag` | **Gamer Tag** | `VARCHAR(40)` | `NOT NULL` | In-game handle |
| `rank_title` | **Rank Title** | `VARCHAR(30)` | `NOT NULL` | Competitive rank |

---

---

### Table: `tbl_tournaments`
**Description**: Domain table for `tbl_tournaments` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tournament_id` | **Tournament Id** | `INT` | `PRIMARY KEY` | Tournament primary key ID |
| `tournament_name` | **Tournament Name** | `VARCHAR(100)` | `NOT NULL` | Tournament title |
| `prize_pool` | **Prize Pool** | `DECIMAL(12,2)` | `NOT NULL` | Prize money USD |

---

---

### Table: `tbl_event_venues`
**Description**: Domain table for `tbl_event_venues` in `Event_Ticketing_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `venue_id` | **Venue Id** | `INT` | `PRIMARY KEY` | Venue primary key ID |
| `venue_name` | **Venue Name** | `VARCHAR(80)` | `NOT NULL` | Arena or Stadium name |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City |
| `seating_capacity` | **Seating Capacity** | `INT` | `NOT NULL` | Capacity seats |

---

---

### Table: `tbl_events`
**Description**: Domain table for `tbl_events` in `Event_Ticketing_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `event_id` | **Event Id** | `INT` | `PRIMARY KEY` | Event primary key ID |
| `venue_id` | **Venue Id** | `INT` | `FOREIGN KEY` | FK to tbl_event_venues |
| `event_title` | **Event Title** | `VARCHAR(100)` | `NOT NULL` | Concert or Game title |
| `event_date` | **Event Date** | `TIMESTAMP` | `NOT NULL` | Event date time |

---

---

### Table: `tbl_ticket_purchases`
**Description**: Domain table for `tbl_ticket_purchases` in `Event_Ticketing_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `purchase_id` | **Purchase Id** | `INT` | `PRIMARY KEY` | Purchase primary key ID |
| `tier_id` | **Tier Id** | `INT` | `FOREIGN KEY` | FK to tbl_ticket_tiers |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Tickets bought |
| `purchase_time` | **Purchase Time** | `TIMESTAMP` | `NOT NULL` | Timestamp |

---

---

### Table: `tbl_ticket_tiers`
**Description**: Domain table for `tbl_ticket_tiers` in `Event_Ticketing_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tier_id` | **Tier Id** | `INT` | `PRIMARY KEY` | Tier primary key ID |
| `event_id` | **Event Id** | `INT` | `FOREIGN KEY` | FK to tbl_events |
| `tier_name` | **Tier Name** | `VARCHAR(30)` | `NOT NULL` | VIP/FLOOR/BALCONY |
| `ticket_price` | **Ticket Price** | `DECIMAL(8,2)` | `NOT NULL` | Price USD |

---

---

### Table: `tbl_comments`
**Description**: Domain table for `tbl_comments` in `Social_Media_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `comment_id` | **Comment Id** | `INT` | `PRIMARY KEY` | Comment primary key ID |
| `post_id` | **Post Id** | `INT` | `FOREIGN KEY` | FK to tbl_posts |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `comment_text` | **Comment Text** | `VARCHAR(255)` | `NOT NULL` | Comment message |

---