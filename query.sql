--১. ইউজার টেবিল
CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  full_name Varchar(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  role VARCHAR(20) CHECK (role IN ('Ticket Manager', 'Football Fan')),
  phone_number VARCHAR(20)
);

--২. ম্যাচ টেবিল 
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(50) NOT NULL,
    base_ticket_price DECIMAL(10, 2) CHECK (base_ticket_price >= 0),
    match_status VARCHAR(20) CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

--৩. বুকিং টেবিল
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    match_id INT,
    seat_number VARCHAR(10),
    payment_status VARCHAR(20) CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost DECIMAL(10, 2) CHECK (total_cost >= 0),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id) ON DELETE CASCADE
);

-- Attached 7 SQL queries 

-- ১. JOIN ব্যবহার করে বুকিং ডিটেইলস
SELECT u.full_name, m.fixture, b.seat_number, b.total_cost 
FROM Users u 
JOIN Bookings b ON u.user_id = b.user_id 
JOIN Matches m ON b.match_id = m.match_id;

-- ২. Subquery ব্যবহার করে সর্বোচ্চ মূল্যের টিকিট
SELECT * FROM Bookings 
WHERE total_cost > (SELECT AVG(total_cost) FROM Bookings);

-- ৩. Aggregation (Sum) দিয়ে ম্যাচের মোট আয়
SELECT m.fixture, SUM(b.total_cost) as total_revenue 
FROM Matches m 
JOIN Bookings b ON m.match_id = b.match_id 
GROUP BY m.fixture;

-- ৪. Pagination ব্যবহার করে ম্যাচের তালিকা
SELECT * FROM Matches 
ORDER BY base_ticket_price ASC 
LIMIT 5 OFFSET 0;

-- ৫. Aggregation (Count) দিয়ে জনপ্রিয় ম্যাচ
SELECT match_id, COUNT(booking_id) as total_bookings 
FROM Bookings 
GROUP BY match_id 
ORDER BY total_bookings DESC;

-- ৬. Complex Join & Filter (Confirmed পেমেন্ট দেখা)
SELECT u.email, m.fixture 
FROM Users u 
JOIN Bookings b ON u.user_id = b.user_id 
JOIN Matches m ON b.match_id = m.match_id 
WHERE b.payment_status = 'Confirmed';

-- ৭. Subquery with In Clause (নির্দিষ্ট দলের ম্যাচ দেখা)
SELECT * FROM Bookings 
WHERE match_id IN (SELECT match_id FROM Matches WHERE fixture LIKE '%Argentina%');
