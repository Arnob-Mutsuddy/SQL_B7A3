
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(20) CHECK (
    role = 'Ticket Manager'
    OR
    role = 'Football Fan'
),
    phone_number VARCHAR(14)
);


--MATCHES TABLE
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(200) NOT NULL,
    tournament_category VARCHAR(100),
    base_ticket_price DECIMAL(10,2) NOT NULL CHECK (base_ticket_price >= 0),
    match_status VARCHAR(25) CHECK (match_status IN 
    ('Available','Selling Fast','Sold Out','Postponed')
  )
);

--BOOKINGS TABLE
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    match_id INT,
    seat_number VARCHAR(15),
    payment_status VARCHAR(25) CHECK (payment_status IN 
    ('Pending','Confirmed','Cancelled','Refunded')),
    total_cost DECIMAL(10,2) CHECK (total_cost >= 0),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id)
);