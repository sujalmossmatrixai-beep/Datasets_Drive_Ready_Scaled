-- ========================================================
-- Master DDL Schema Script for Dataset_06_DigitalMedia_Gaming_Entertainment_Social_20x30_source
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 20
-- Domains Included: Dataset_10_Digital_Streaming_Media_Dataset, Dataset_13_Event_Ticketing_Platform_Dataset, Dataset_16_Gaming_Esports_Dataset, Dataset_26_Social_Media_Platform_Dataset
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
